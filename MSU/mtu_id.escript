#!/usr/bin/env escript
% Sets all pps stations in debug mode

main(Args) ->
    net_kernel:start([shell, shortnames]),
    erlang:set_cookie(node(), butler_server),
    {ok,MtuTypeRackIds} = rpc:call(erlang:list_to_atom("butler_server@localhost"),rackinfo,search_by,[[{type,equal,mtu}],key]),
    %%io:format("Total MTU ~p~n", [length(MtuTypeRackIds)]),
    rpc:call(erlang:list_to_atom("butler_server@localhost"),lists, foreach,[
        fun(MtuId) ->
                %%io:format("Rack ~p~n", [MtuId]),
                {ok, [[MtuSlots]]} = rpc:call(erlang:list_to_atom("butler_server@localhost"),slots,search_by,[[{id,equal,MtuId}],[slotid_list]]),
                %%io:format("Total MTU Slot ~p~n", [length(MtuSlots)]),
                lists:foreach(
                    fun(SlotId) ->
                        %%io:format("Checking slot  ~p~n", [SlotId]),
                        {ok, StorageNode} = rpc:call(erlang:list_to_atom("butler_server@localhost"),storage_node,get_by_id,[SlotId]),
                        Storage_properties=element(4,StorageNode),
                        CarrierIds = rpc:call(erlang:list_to_atom("butler_server@localhost"),maps,get,[carrier_ids, Storage_properties, []]),
                        %%io:format("CarrierIds  ~p~n", [CarrierIds]),
                        Tote=Args,
                        Tote_id=list_to_binary(Tote),
                        Output=rpc:call(erlang:list_to_atom("butler_server@localhost"),lists,member,[Tote_id, CarrierIds]),
                        if
                          Output=:=true ->
                          io:format("Tote ID Match FOUND, Slot Details: ~p , Tote ID: ~p , MTU_ID: ~p ~n", [SlotId,CarrierIds,MtuId]);
                        true -> io:format("")
                        end
                    end, MtuSlots)
            end, MtuTypeRackIds]).
