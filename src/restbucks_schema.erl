-module(restbucks_schema).

-export([create_product/2, init_tables/0, clear_tables/0, delete_tables/0, populate_products/0, read_product/1, get_all_products/0]).

-include("include/restbucks_datatypes.hrl").

init_tables() ->
    mnesia:create_table(restbucks_product, [{ attributes, record_info(fields, restbucks_product)}]).

clear_tables() ->
    mnesia:clear_table(restbucks_product).

delete_tables() ->
    mnesia:delete_table(restbucks_product).

populate_products() ->
    Fill = fun() ->
        mnesia:write({restbucks_product, "Cappucino", 6.70 }),
        mnesia:write({restbucks_product, "Cookie", 1.00 }),
        mnesia:write({restbucks_product, "Espresso", 6.90 }),
        mnesia:write({restbucks_product, "Hot Chocolate", 10.50 }),
        mnesia:write({restbucks_product, "Latte", 7.60 }),
        mnesia:write({restbucks_product, "Tea", 8.40 })
    end,
    case mnesia:transaction(Fill) of
        { atomic, ok } -> ok
    end.

create_product(Name, Price) ->
    io:format("~p Product created: ~p, ~p~n", [?LINE, Name, Price]),
    Write = fun() -> mnesia:write({ restbucks_product, Name, Price }) end,
    case mnesia:transaction(Write) of
        { atomic, ok } -> ok
    end.

read_product(Name) ->
    Read = fun() -> mnesia:read(restbucks_product, Name) end,
    case mnesia:transaction(Read) of
        { atomic, [Product] } -> Product;
        { atomic, [] } -> { error, not_exists }
    end.

get_all_products() ->
    GetAll = fun() -> mnesia:match_object({ restbucks_product, '_', '_' }) end,
    case mnesia:transaction(GetAll) of
        { atomic, Results } -> Results
    end.

