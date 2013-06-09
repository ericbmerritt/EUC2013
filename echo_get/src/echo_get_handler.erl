%%%-------------------------------------------------------------------
%%% @author Eric Merritt <ericbmerritt@gmail.com>
%%% @copyright (C) Erlware
%%% @doc
%%%  GET echo handler.
%%% @end
%%%-------------------------------------------------------------------
-module(echo_get_handler).

-export([init/3,
         handle/2,
         terminate/3]).

%%%===================================================================
%%% Http handler callbacks
%%%===================================================================

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {Method, Req2} = cowboy_req:method(Req),
    {Echo, Req3} = cowboy_req:qs_val(<<"echo">>, Req2),
    {ok, Req4} = echo(Method, Echo, Req3),
    {ok, Req4, State}.

echo(<<"GET">>, undefined, Req) ->
    cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
echo(<<"GET">>, Echo, Req) ->
    cowboy_req:reply(200,
                     [{<<"content-encoding">>, <<"utf-8">>}], Echo, Req);
echo(_, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).

terminate(_Reason, _Req, _State) ->
    ok.
