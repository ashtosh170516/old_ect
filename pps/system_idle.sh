#!/bin/bash
system_idle () {
 	echo "Checking system sanity, Result: {ok,[]} means that particular component is empty (not present in the system)"
    echo "<br>"
    if [ "$1" -eq "1" ]; then
    	echo "<br>"
    	echo "##################################################"
      check_pps_status
      sleep 0.1
    	check_putoutput1
    	sleep 0.1
    	check_auditrec_without_created
    	sleep 0.1
    	check_auditlinerec_without_created
    	sleep 0.1
    	check_pick_instruction
    	sleep 0.1
    	check_pending_search_request
    	sleep 0.1
    	check_order_without_created
    	sleep 0.1
    	check_order_in_created
    	sleep 0.1
    	check_all_bins
    	sleep 0.1
    	check_inconsistent_storage_locations
    	sleep 0.1
    	check_reconfig_task
    	sleep 0.1
    	check_butler_movetask_task
    	sleep 0.1
    	check_butler_picktask_task
    	sleep 0.1
    	check_butler_audittask_task
    	sleep 0.1
      check_butler_chargetask_task
      sleep 0.1
      check_charge_task
      sleep 0.1
    	check_pps_task
    	sleep 0.1
    	check_audit_task
    	sleep 0.1
    	check_block_storage_node

    elif [ "$1" -eq "2" ]; then
    	echo "<br>"
    	echo "##################################################"
      check_pps_status
      sleep 0.1
    	check_putoutput1
    	sleep 0.1
    	check_auditrec_with_created
    	sleep 0.1
    	check_auditlinerec_with_created
    	sleep 0.1
    	check_pick_instruction
    	sleep 0.1
    	check_pending_search_request
    	sleep 0.1
    	check_order_without_created
    	sleep 0.1
    	check_order_in_created
    	sleep 0.1
    	check_all_bins
    	sleep 0.1
    	check_inconsistent_storage_locations
    	sleep 0.1
    	check_reconfig_task
    	sleep 0.1
    	check_butler_movetask_task
    	sleep 0.1
    	check_butler_picktask_task
    	sleep 0.1
    	check_butler_audittask_task
    	sleep 0.1
      check_butler_chargetask_task
      sleep 0.1
      check_charge_task
      sleep 0.1
    	check_pps_task
    	sleep 0.1
    	check_audit_task
    	sleep 0.1
    	check_block_storage_node
    	sleep 0.1

    else 
        echo "Wrong Key pressed"
    fi
}
check_pps_status () {
    echo "<br>"
    echo "PPS which are logged in and its Mode"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'}], ['pps_id','mode']]."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}

check_putoutput1 () {
    echo "<br>"
    echo "Pending PUT Order item."
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript put_output1 search_by "[[{'status', 'notequal', 'completed'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Not completed Put outputs are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript put_output1 search_by "[[{'status', 'notequal', 'completed'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_auditrec_without_created () {
    echo "<br>"
    echo "Pending Audit (excluding created status)"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'status', 'notin', ['audit_aborted','audit_completed','audit_resolved','audit_reaudited','audit_cancelled','audit_created']}], [display_id,audit_id]]." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending Auditrec are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'status', 'notin', ['audit_aborted','audit_completed','audit_resolved','audit_reaudited','audit_cancelled','audit_created']}],  [display_id,audit_id]]."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_auditrec_with_created () {
    echo "<br>"
    echo "Pending Audit (including created status)"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'status', 'notin', ['audit_aborted','audit_completed','audit_resolved','audit_reaudited','audit_cancelled']}],  [display_id,audit_id]]." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending Auditrec are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'status', 'notin', ['audit_aborted','audit_completed','audit_resolved','audit_reaudited','audit_cancelled']}],[display_id,audit_id]]."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi    
}
check_auditlinerec_without_created () {
    echo "<br>"
    echo "Pending Audit lines (excluding created status)"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditlinerec1 search_by "[[{'status', 'notin', ['audit_completed','audit_resolved','audit_reaudited','audit_cancelled','audit_created']}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending Auditlinerec are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditlinerec1 search_by "[[{'status', 'notin', ['audit_completed','audit_resolved','audit_reaudited','audit_cancelled','audit_created']}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_auditlinerec_with_created () {
    echo "<br>"
    echo "Pending Audit lines (including created status)"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditlinerec1 search_by "[[{'status', 'notin', ['audit_completed','audit_resolved','audit_reaudited','audit_cancelled']}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending Auditlinerec are 30+".
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditlinerec1 search_by "[[{'status', 'notin', ['audit_completed','audit_resolved','audit_reaudited','audit_cancelled']}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}

check_pick_instruction () {
    echo "<br>"
    echo "All pending pick_instruction in the system"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript pick_instruction search_by "[[{'status', 'notequal', 'complete'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending pick_instruction are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript pick_instruction search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}

check_pending_search_request () {
    echo "<br>"
    echo "Pending search request in the system"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript search_line search_by "[[{'status', 'notequal', 'complete'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending search request are 30+".
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript search_line search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_order_without_created () {
    echo "<br>"
    echo "All pending orders (excluding created status) in the system"
    echo "<br>"
    count_of_order=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'notin', ['complete','abandoned','cancelled','unfulfillable','created']}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`

    if [ "$count_of_order" -ge "30" ]; then
       echo "Non terminated Orders are 30+".
       echo "<br>"
       echo "<br>"
       echo "Total Order Count: " $count_of_order
       count_pending=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'pending'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_paused=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'inventory_awaited'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_unprocessable=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'unprocessable'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_temporary_unfulfillable=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'temporary_unfulfillable'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       echo "<br>"
       echo "<br>"
       echo "Pending Order Count: " $count_pending
       echo "<br>"
       echo "Paused Order Count: " $count_paused
       echo "<br>"
       echo "Block by Audit(temporary_unfulfillable) Order Count: " $count_temporary_unfulfillable
       echo "<br>"
       echo "Unprocessable Order Count: " $count_unprocessable
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$count_of_order" -lt "30" ]; then
       echo "<br>"
       echo "<br>"
       echo "Total Order Count: " $count_of_order
       count_pending=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'pending'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_paused=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'inventory_awaited'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_unprocessable=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'unprocessable'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       count_temporary_unfulfillable=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'temporary_unfulfillable'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
       echo "<br>"
       echo "<br>"
       echo "Pending Order Count: " $count_pending
       echo "<br>"
       echo "Paused Order Count: " $count_paused
       echo "<br>"
       echo "Block by Audit(temporary_unfulfillable) Order Count: " $count_temporary_unfulfillable
       echo "<br>"
       echo "Unprocessable Order Count: " $count_unprocessable
       echo "<br>"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'notin', ['complete','abandoned','cancelled','unfulfillable','created']}], [order_node_id,status]]." 
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count_of_order"
        echo "<br>"
    	echo "##################################################"
        echo "<br>"
    fi
}
check_order_in_created () {
    echo "<br>"
    echo "Count of Orders in created state"
    echo "<br>"
    count_of_order=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node search_by "[[{'status', 'equal', 'created'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
    echo "<br>"
    echo "<br>"
    echo "Created Order Count: " $count_of_order
    echo "<br>"
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_all_bins () {
    echo "<br>"
    echo "All bins which are not having status IDLE/inactive"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsbinrec search_by "[[{'status', 'notequal', 'idle'},{'status', 'notequal', 'inactive'}], 'key']." | grep  -o '"' | wc  -l`
    echo "<br>"
    echo "Total Count: $((count/2))"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsbinrec search_by "[[{'status', 'notequal', 'idle'},{'status', 'notequal', 'inactive'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_inconsistent_storage_locations () {
    echo "<br>"
    echo "Check Inconsistent storage locations"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/MSU/inconsistent_rack.escript
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_reconfig_task () {
    echo "<br>"
    echo "All pending Msu Reconfig Task"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript reconfigtaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_butler_movetask_task () {
    echo "<br>"
    echo "All Butler Id's which are having movetask assigned"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'movetask'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
    echo "Total Count:" $count
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'movetask'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_butler_picktask_task () {
    echo "<br>"
    echo "All Butler Id's which are having pick/put task assigned"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'picktask'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
    echo "Total Count:" $count
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'picktask'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_butler_audittask_task () {
    echo "<br>"
    echo "All Butler Id's which are having audittask assigned"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'audittask'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
    echo "Total Count:" $count
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'audittask'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_butler_chargetask_task () {
    echo "<br>"
    echo "All Butler Id's which are having chargetask assigned"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'chargetask'}], 'key']." | grep -o "[[:digit:]]\+"  | wc -l`
    echo "Total Count:" $count
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'tasktype', 'equal', 'chargetask'}], 'key']."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}
check_charge_task () {
    echo "<br>"
    echo "All pending ChargeTask"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript chargetaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending chargetask are 30+".
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript chargetaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}

check_pps_task () {
    echo "<br>"
    echo "All pending PICK/PUT Task"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppstaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending PICK/PUT task are 30+".
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppstaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_audit_task () {
    echo "<br>"
    echo "All pending Audit Task"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript audittaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']." | grep  -o '"' | wc  -l`
    if [ "$((count/2))" -ge "30" ]; then
       echo "Pending Audit task are 30+".
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    elif [ "$((count/2))" -lt "30" ]; then
       echo "<br>"
       echo "Total Count: $((count/2))"
       echo "<br>"
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript audittaskrec search_by "[[{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
       echo "<br>"
       echo "##################################################"
       echo "<br>"
    else 
        echo "Wrong value of count"
        echo "<br>"
        echo "##################################################"
        echo "<br>"
    fi
}
check_block_storage_node () {
    echo "<br>"
    echo "All block storage node because of Audit"
    echo "<br>"
    count=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript storage_node search_by "[[{properties, equal, #{audit_marked => true}}],key]." | grep  -o '"' | wc  -l`
    echo "<br>"
    echo "Total Count: $((count/2))"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript storage_node search_by "[[{properties, equal, #{audit_marked => true}}],key]."
    echo '</pre>'
    echo "<br>"
    echo "##################################################"
    echo "<br>"
}

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Checking System Idle</title>'
echo '<link rel="stylesheet" href="/rack.css" type="text/css">'
echo '</head>'
echo '<body>'
echo '<div class=container>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>Type 1 for avoiding audit in created and 2 for including audit in created state</TD><TD><input type="number" name="Type 1 for avoiding audit in created and 2 for including audit in created state" size=12></td></tr>'\
		  '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
   # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*state=\([^ ]*\).*$/\1/p'`
     echo '<br>'
     system_idle $XX   
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0