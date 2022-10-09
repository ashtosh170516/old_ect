#!/bin/bash
source /home/gor/easy_console/variable.sh
metabase_restart () {
    echo "Restarting Metabase"
    echo "<br>"
    if [ "$1" -eq "1" ]; then
      echo '<pre>'
      sshpass -p "$PASSWORD_OF_METRIC" ssh -o StrictHostKeyChecking=no -t $USERNAME@$METRIC_IP "echo '2sMcZ3pdTcp5v'| sudo -S docker restart metabase-new"
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
echo '<title>Metabase restart</title>'
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
		  '<tr><td>Type 1 for metabase restart</TD><TD><input type="number" name="Type 1 for metabase restart" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*restart=\([^ ]*\).*$/\1/p'`
	
	   echo "Type 1 for metabase restart " $XX
     echo '<br>'
     metabase_restart $XX 
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0