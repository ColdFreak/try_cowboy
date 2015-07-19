-module(cowboy_post_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch =  cowboy_router:compile([
        {'_', [
                {"/js/[...]", cowboy_static, {priv_dir, cowboy_post, "static/js"}},
                {"/controllers/[...]", cowboy_static, {priv_dir, cowboy_post, "static/controllers"}},

                {"/", cowboy_static, {priv_file, cowboy_post, "static/index.html" }},
                {"/process_echo", echo_handler, []},

                {"/angular", cowboy_static, {priv_file, cowboy_post, "static/angular.html" }},

                {"/rpn", cowboy_static, {priv_file, cowboy_post, "static/rpn.html" }},
                {"/process_rpn", rpn_handler, []}
              ]
        }
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 3333}], [
        {env, [{dispatch, Dispatch}]}
    ]),
    cowboy_post_sup:start_link().

stop(_State) ->
    ok.
