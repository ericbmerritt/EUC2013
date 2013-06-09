%%%-------------------------------------------------------------------
%%% @author Eric Merritt <ericbmerritt@gmail.com>
%%% @copyright (C) Erlware
%%%-------------------------------------------------------------------
-module(echo_get_app).
-behaviour(application).

%% API.
-export([start/2,
         stop/1]).

%%%===================================================================
%%% API
%%%===================================================================
start(_Type, _Args) ->
    echo_get_sup:start_link().

stop(_State) ->
        ok.
