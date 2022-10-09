#!/usr/bin/env escript
% Sets all pps stations in debug mode

main(_) ->
    net_kernel:start([shell, shortnames]),
    erlang:set_cookie(node(), butler_server),
    CheckPBT =
	  fun(PBT) ->
	    case PBT of
	    {{_,_,_}, {_,_,_}} ->
	      Now = rpc:call(erlang:list_to_atom("butler_server@localhost"),calendar, universal_time, []),
	      TimeToBreach=rpc:call(erlang:list_to_atom("butler_server@localhost"),calendar, datetime_to_gregorian_seconds,[PBT]) - rpc:call(erlang:list_to_atom("butler_server@localhost"),calendar, datetime_to_gregorian_seconds,[Now]),
	      if
	        TimeToBreach < 0 -> breached;
	        TimeToBreach > 1800 -> ok;
	        true -> about_to_breach
	      end;
	    _ -> undefined
	    end
	  end,
	StrTime =
	  fun(PBT) ->
	    case PBT of
	      {{Year,Month,Day},{Hour,Minute,Second}} ->
	        lists:flatten(io_lib:format("~4..0w-~2..0w-~2..0wT~2..0w:~2..0w:~2..0wZ",[Year,Month,Day,Hour,Minute,Second]));
	      _ -> "undefined"
	    end
	  end,
	{ok,OCreated}=rpc:call(erlang:list_to_atom("butler_server@localhost"),order_node, search_by, [[{status,equal,created}],key]),
	{ok,OInventoryAwaited}=rpc:call(erlang:list_to_atom("butler_server@localhost"),order_node, search_by, [[{status,equal,inventory_awaited}],key]),
	{ok,OTempUnfulfillable}=rpc:call(erlang:list_to_atom("butler_server@localhost"),order_node, search_by, [[{status,equal,temporary_unfulfillable}],key]),
	Orders = OCreated ++ OInventoryAwaited ++ OTempUnfulfillable,
	rpc:call(erlang:list_to_atom("butler_server@localhost"),lists, foreach,[
	  	fun(OrderId) ->
	    {ok,Order} = rpc:call(erlang:list_to_atom("butler_server@localhost"),order_node, get_by_id, [OrderId]),
	    Status = element(10,Order),
	    OrderProperties = element(11,Order),
	    {CreatedDate,inherit} = rpc:call(erlang:list_to_atom("butler_server@localhost"),maps, get, [creation_date, OrderProperties]),
	    {PBT,inherit} = rpc:call(erlang:list_to_atom("butler_server@localhost"),maps, get, [pick_before_time, OrderProperties]),
	    ExternalId = element(1,rpc:call(erlang:list_to_atom("butler_server@localhost"),maps, get, [externalServiceRequestId, OrderProperties])),
	    Abc=CheckPBT(PBT),
	    Pbt=StrTime(PBT),
	    Created_date=StrTime(CreatedDate),
	     if
	      Abc=:=breached ->
	      io:format("~p,~p,~p,~p,~p~n", [rpc:call(erlang:list_to_atom("butler_server@localhost"),erlang, binary_to_list, [ExternalId]),Abc,Pbt,Created_date,Status]);
	      Abc=:=about_to_breach ->
	      io:format("~p,~p,~p,~p,~p~n", [rpc:call(erlang:list_to_atom("butler_server@localhost"),erlang, binary_to_list, [ExternalId]),Abc,Pbt,Created_date,Status]);
	      true -> io:format("")
	    end
	end,
	Orders]).
	












