%%%-------------------------------------------------------------------
%%% @author Eric Merritt <ericbmerritt@gmail.com>
%%% @copyright (C) Erlware
%%%-------------------------------------------------------------------
-module(echo_get).

%% API.
-export([manual_start/0]).

%%%===================================================================
%%% API
%%%===================================================================
manual_start() ->
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowboy),
    ok = application:start(echo_get).
