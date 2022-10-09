#!/bin/bash
pick_task_pps () {
    echo "All Pick Task Associated on that PPS : $1"
    echo "<br>"
    if [ "$2" -eq "1" ]; then
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppstaskrec search_by "[[{'pps_id', 'equal',$1},{'status', 'notequal', 'complete'}], 'key']."
       echo '</pre>'
    elif [ "$2" -eq "2" ]; then
       echo '<pre>'
       sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppstaskrec search_by "[[{'pps_id', 'equal',$1},{'status', 'notequal', 'complete'}], 'record']."
       echo '</pre>'
    else 
        echo "Wrong Key pressed"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>All pending pps task on PPS</title>'
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
          '<tr><td>PPS_ID</TD><TD><input type="number" name="PPS_ID" size=12></td></tr>'\
		  '<tr><td>Type 1 for key and 2 for record</TD><TD><input type="number" name="Type 1 for key and 2 for record" size=12></td></tr>'\
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
	 YY=`echo "$QUERY_STRING" | sed -n 's/^.*record=\([^ ]*\).*$/\1/p'`
	
     echo "PPS_ID: " $XX
     echo '<br>'
	   echo "Type 1 for key and 2 for record: " $YY
     echo '<br>'
     pick_task_pps $XX $YY 
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0