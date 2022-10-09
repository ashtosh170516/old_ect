#!/bin/bash
delete_chargetask () {
    echo "Checking any butler with same Taskkey"
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'taskkey', 'equal', <<\"$1\">>}], 'record']."
    echo '</pre>'
    bot_ip=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo search_by "[[{'taskkey', 'equal', <<\"$1\">>}], 'record']." | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    echo "<br>"
    echo "Butler Ip: $bot_ip"
    echo "<br>"
    if [ ! -n "$bot_ip" ]
    then
        echo "Butler is Not Present....Deleting a charge task"
        curl -X POST -H 'Content-Type: application/json' -d '{"table_name":"chargetask","key" : "'"$1"'"}' localhost:8181/api/mhs/task/delete
        echo "<br>"
        echo "Ok....Done"
        
    else
        echo "Butler Found Aborting Charge task deletion"
        echo "<br>"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Delete a Charge Task</title>'
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
          '<tr><td>Task_Key</TD><TD><input type="text" name="Task_Key" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*Task_Key=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
	 
	   echo "chargeTask_Key: <<"$XX">>"
     echo '<br>'
     delete_chargetask $XX
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
