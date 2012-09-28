-module(restbucks_orders_resource).
-export([init/1, allowed_methods/2, content_types_accepted/2, post_is_create/2, create_path/2, from_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(Config) ->
    { { trace, "traces" }, Config }.

allowed_methods(ReqData, State) ->
    { [ 'POST' ], ReqData, State }.

content_types_accepted(ReqData, State) ->
    { [ { "application/json", from_json } ], ReqData, State }.

post_is_create(ReqData, State) ->
    { true, ReqData, State }.

create_path(ReqData, State) ->
    Path = "/order/1",
    { Path, ReqData, State }.

from_json(ReqData, State) ->
    { struct, Order } = mochijson2:decode(wrq:req_body(ReqData)),
    wrq:set_resp_header("Location", "1", ReqData),
    { true, ReqData, State }.

