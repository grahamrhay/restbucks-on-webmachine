-module(restbucks_schema_tests).

-include_lib("eunit/include/eunit.hrl").

create_product_test() ->
    ?assertEqual(ok, restbucks_schema:create_product("Coffee", 3.4)),
    ?assertEqual([{ restbucks_product, "Coffee", 3.4 }], mnesia:dirty_read(restbucks_product, "Coffee")),
    mnesia:dirty_delete(restbucks_product, "Coffee"),
    ?assertEqual([], mnesia:dirty_read(restbucks_product, "Coffee")).
