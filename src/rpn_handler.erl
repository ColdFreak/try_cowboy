-module(rpn_handler).

-export([init/2]).

init(Req, Opts) ->
    Method = cowboy_req:method(Req),
    HasBody = cowboy_req:has_body(Req),
    Req2 = process_rpn(Method, HasBody, Req),
    {ok, Req2, Opts}.

process_rpn(<<"POST">>, true, Req) ->
    {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
    Rpn = proplists:get_value(<<"rpnInput">>, PostVals),
    %% erlang:display(PostVals),
    %% [{A, B}] = PostVals,
    %% io:format("~p", [Rpn]),
    %% io:format("~p", [A]),
    %% io:format("~p", [B]),
    Result = do_rpn(Rpn),
    rpn_reply(Result, Req2);
process_rpn(<<"POST">>, false, Req) ->
    cowboy_req:reply(400, [], <<"Missing body.">>, Req);
process_rpn(_, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).

rpn_reply(undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
rpn_reply(Result, Req) ->
    cowboy_req:reply(200, 
                    [
                      {<<"content-type">>, <<"text/plain; charset=utf-8">>}
                    ], Result, Req
    ).

do_rpn(B) when is_binary(B) ->
    L = binary_to_list(B),
    [Res] = lists:foldl(fun do_rpn/2, [], string:tokens(L, " ")),
    case is_float(Res) of
        true ->
            list_to_binary(float_to_list(Res, [{decimals, 2}]));
        false ->
            list_to_binary(integer_to_list(Res))
    end.

read(N) ->
    case string:to_float(N) of
        {error, no_float} ->
            list_to_integer(N);
        {F, _} ->
            F
    end.

do_rpn("+", [N1, N2|S]) -> [N2 + N1|S];
do_rpn("-", [N1, N2|S]) -> [N2 - N1|S];
do_rpn("*", [N1, N2|S]) -> [N2 * N1|S];
do_rpn("/", [N1, N2|S]) -> [N2 / N1|S];
do_rpn("^", [N1, N2|S]) -> [math:pow(N2, N1)|S];
do_rpn("ln", [N|S])     -> [math:log(N)|S];
do_rpn("log10", [N|S])  -> [math:log10(N)|S];
% sumの場合も同じで、戻り値はfoldlの二個目の引数を書き換える
% 要はアキュミュレータは足されていく
do_rpn("sum", Stack)    -> [lists:sum(Stack)];
do_rpn(X, Stack)        -> [read(X) | Stack].
