-module(menu_resource).
-export([init/1, content_types_provided/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Config) ->
    restbucks_schema:populate_products(),
    {{trace, "traces"}, Config}.

content_types_provided(ReqData, State) ->
    { [ { "application/json", to_json } ], ReqData, State }.

to_json(ReqData, State) ->
    Response = mochijson2:encode(get_menu()),
    UpdatedReqData = wrq:set_resp_header("Access-Control-Allow-Origin", "*", ReqData),
    { Response, UpdatedReqData, State }.

get_menu() ->
    { struct, [
        { 'Items', get_menu_items() }
    ]}.

get_menu_items() ->
    Products = restbucks_schema:get_all_products(),
    ProductToJson = fun({restbucks_product, Name, Price}) -> { struct, [ { 'Name', erlang:iolist_to_binary(Name) }, { 'Price', Price }]} end,
    lists:map(ProductToJson, Products).

