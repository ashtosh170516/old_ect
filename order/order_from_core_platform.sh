#!/bin/bash
source /home/gor/easy_console/variable.sh
order_information () {
    order_id=`sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/test.sh $1 " | head -3 | tail -1 | grep -o '[[:digit:]]*'`
    echo "<br>"
    echo $order_id
    echo "<br>"
    echo "Order status from platform"
    echo '<pre>'
    sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/updated_status.sh $1 "
    echo '</pre>'
    echo "Status on Core"
    echo '<pre>'
    sudo /opt/butler_server/erts-9.3.3.6/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_node get_by_id "[<<\"$order_id\">>]."
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>order from core and platform</title>'
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
          '<tr><td>External_Service_Request_ID</TD><TD><input type="text" name="External_Service_Request_ID" size=12></td></tr>'\
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
     echo '<hr>'
     echo '<h3 align="center">RESPONSE</h3>'
     echo '<hr>'
   # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*External_Service_Request_ID=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    
     echo "External_Service_Request_ID: " $XX
     echo '<br>'
     order_information $XX 
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0