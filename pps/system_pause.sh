#!/bin/bash
system_pause () {
    controller_id=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript zigbee_peripherals search_by "[[{state_data,equal,[{zone,<<\"Zone$1\">>},'_','_','_']}], ['peripheral_id']]." | cut -d'"' -f2`
    echo "$controller_id"
    if [ "$controller_id" == "Result: {ok,[]}" ]; then
      echo "<br>"
      echo "Zone doesn't exist in the system"
      echo "<br>"
    else
      echo "<br>"
      echo "System pause for Controller Id : <<'$controller_id'>> "
      echo "<br>"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript generic_peripheral apply_emergency_pause "[<<\"$controller_id\">>]."
      echo '</pre>'
      echo "<br>"
    fi
    echo "<br>"

}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Remove zone_pause</title>'
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
          '<tr><td>Zone_ID</TD><TD><input type="number" name="Zone_ID" size=12></td></tr>'\
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
	
     echo "Zone_ID: " $XX
     echo '<br>'
     system_pause $XX  
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0