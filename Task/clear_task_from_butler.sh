#!/bin/bash
clear_task_from_butler () {
    echo '<pre>'
    taskkey=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'id', 'equal', $1}], ['taskkey']]." | cut -d'"' -f2`
    tasktype=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'id', 'equal', $1}], ['tasktype']]." | sed 's/.*\[\([^]]*\)].*/\1/'`
    echo '</pre>'
    echo "<br>"
    if [ "$tasktype" == "picktask" ] ; then
        task_status=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppstaskrec search_by "[[{'task_key', 'equal', <<\"$taskkey\">>}], ['status']]." | sed 's/.*\[\([^]]*\)\].*/\1/g' | sed 's/^.*,//;s/}$//'`
        if [ "$task_status" == "complete" ] || [ -z $task_status ]; then
                echo "Clearing task & Subtask from butler"
                echo "<br>"
                sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo update_columns_by_id "[$1,[{'taskkey','null'},{'tasktype','null'}]]."
                sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butler_functions clear_butler_subtasks "[$1]."
                echo "<br>"
        else
          echo "Task key exist and not in complete state Taskkey:$taskkey , type:$tasktype , Status:$task_status "
        fi
    elif [ "$tasktype" == "audittask" ]; then
        task_status=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript audittaskrec search_by "[[{'task_key', 'equal', <<\"$taskkey\">>}], ['status']]." | sed 's/.*\[\([^]]*\)\].*/\1/g' | sed 's/^.*,//;s/}$//'`
        if [ "$task_status" == "complete" ] || [ -z $task_status ]; then
                echo "Clearing task & Subtask from butler"
                echo "<br>"
                sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo update_columns_by_id "[$1,[{'taskkey','null'},{'tasktype','null'}]]."
                sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butler_functions clear_butler_subtasks "[$1]."
                echo "<br>"
        else
          echo "Task key exist and not in complete state Taskkey:$taskkey , type:$tasktype , Status:$task_status "
        fi
    else
        echo "Butler contain different tasktype than pick/audit : $tasktype"
    fi    
    echo "<br>"
            
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Clear storing task from Butler</title>'
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
          '<tr><td>Butler_ID</TD><TD><input type="number" name="Butler_ID" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/'`
     
     echo "Butler_ID: " $XX
     echo '<br>'
     

     clear_task_from_butler $XX 
     
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0

