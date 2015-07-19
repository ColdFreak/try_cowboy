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

    rpn(Rpn, Req2);
process_rpn(<<"POST">>, false, Req) ->
    cowboy_req:reply(400, [], <<"Missing body.">>, Req);
process_rpn(_, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).

rpn(undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
rpn(Rpn, Req) ->
    cowboy_req:reply(200, 
                    [
                      {<<"content-type">>, <<"text/plain; charset=utf-8">>}
                    ], Rpn, Req
    ).
