#!/usr/bin/env escript
% Sets all pps stations in debug mode

main(_) ->
    net_kernel:start([shell, shortnames]),
    erlang:set_cookie(node(), butler_server),
    {ok,Storable_position}=rpc:call(erlang:list_to_atom("butler_server@localhost"),storage_info, get_all, [key]),
    {ok,RackPos}=(rpc:call(erlang:list_to_atom("butler_server@localhost"),rackinfo,get_all,[[position]])),
    RackPosition_All=lists:append(RackPos),
    Rack_Id_on_Non_Storable_position = lists:subtract(lists:usort(RackPosition_All),lists:usort(Storable_position)),
    {ok,Rack_Id_on_Non_Storable}=rpc:call(erlang:list_to_atom("butler_server@localhost"),rackinfo,search_by,[[{position,in, Rack_Id_on_Non_Storable_position}],key]),
    io:format("Result: ~p~n",[Rack_Id_on_Non_Storable]).
