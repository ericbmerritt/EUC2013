%%%-------------------------------------------------------------------
%%% @author Eric Merritt <ericbmerritt@gmail.com>
%%% @copyright (C) Erlware
%%%-------------------------------------------------------------------
-module(echo_get_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor.
-export([init/1]).

-include("echo_get.hrl").

%%%===================================================================
%%% API
%%%===================================================================
-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================
init([]) ->
    Dispatch = cowboy_router:compile(?DISPATCH),
    Procs = [ranch:child_spec(pangolin_cowboy, 100, ranch_tcp,
                              [{port, 8080}],
                              cowboy_protocol,
                              [{env,
                                [{dispatch, Dispatch}]}])],

    {ok, {{one_for_one, 10, 10}, Procs}}.
