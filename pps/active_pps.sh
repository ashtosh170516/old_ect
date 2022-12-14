#!/bin/bash
active_pps () {
    echo "All PPS which is active and Login are: "
    echo "<br>"
    if [ "$1" -eq "1" ]; then
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'}], 'key']."
      echo '</pre>'
      echo "PPS which is in Pick"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'pick'}], 'key']."
      echo '</pre>'
      echo "PPS which is in Put"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'put'}], 'key']."
      echo '</pre>'
      echo "PPS which is in Audit"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'audit'}], 'key']."
      echo '</pre>'
    elif [ "$1" -eq "2" ]; then
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'}], 'record']."
      echo '</pre>'
      echo "PPS which is in Pick"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'pick'}], 'record']."
      echo '</pre>'
      echo "PPS which is in Put"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'put'}], 'record']."
      echo '</pre>'
      echo "PPS which is in Audit"
      echo '<pre>'
      sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsnode search_by "[[{'active_status', 'equal', 'true'},{'mode', 'equal', 'audit'}], 'record']."
      echo '</pre>'
    else 
        echo "Wrong Choice"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get All Active/Online PPS</title>'
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
          '<tr><td>Type_1 for_key_2_for record</TD><TD><input type="number" name="Type_1 for_key_2_for record" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){3}.*/\2/'`
	
     echo "Type_1 for_key_2_for record: " $XX
     echo '<br>'
     active_pps $XX    
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
