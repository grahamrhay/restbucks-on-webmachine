%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the restbucks application.

-module(restbucks_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for restbucks.
start(_Type, _StartArgs) ->
    restbucks_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for restbucks.
stop(_State) ->
    ok.
