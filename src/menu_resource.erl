-module(menu_resource).
-export([init/1, content_types_provided/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Config) ->
    {{trace, "traces"}, Config}.

content_types_provided(ReqData, State) ->
    { [ { "application/json", to_json } ], ReqData, State }.

to_json(ReqData, State) ->
    Response = mochijson2:encode(get_menu()),
    {Response, ReqData, State}.

get_menu() ->
    { struct, [
        { 'Items', get_menu_items() }
    ]}.

get_menu_items() ->
    [
        { struct, [
            { 'Name', <<"Cappucino">> },
            { 'Price', 6.70 }
        ]},
        { struct, [
            { 'Name', <<"Cookie">> },
            { 'Price', 1.00 }
        ]},
        { struct, [
            { 'Name', <<"Espresso">> },
            { 'Price', 6.90 }
        ]},
        { struct, [
            { 'Name', <<"Hot Chocolate">> },
            { 'Price', 10.50 }
        ]},
        { struct, [
            { 'Name', <<"Latte">> },
            { 'Price', 7.60 }
        ]},
        { struct, [
            { 'Name', <<"Tea">> },
            { 'Price', 8.40 }
        ]}
    ].
