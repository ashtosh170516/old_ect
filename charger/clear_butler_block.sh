#!/bin/bash
clear_block_butler () {
    attached_butler=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript chargerinfo search_by "[[{'charger_id', 'equal', $1}], ['attached_butler_id']]." | sed 's/.*\[\([^]]*\)\].*/\1/g'`
    echo "Attached butler : $attached_butler"
    if [ "$attached_butler" == "undefined" ]; then
      echo "<br>"
      echo "<br>"
      echo "Clearing block Butler from Charger_ID: $1"
      echo "<br>"
      sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript chargerinfo update_columns_by_id "[$1,[{'blocked_by_butler_ids',[]}]]."
    else
      echo "<br>"
      echo "<br>"
      echo "Butler is attached from charger, first clear attached butler then use this command"
      echo "<br>"
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Clear block butler</title>'
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
          '<tr><td>CHARGER_ID</TD><TD><input type="number" name="ORDER_ID" size=12></td></tr>'\
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
	
     echo "Charger_ID: " $XX
     echo '<br>'
     clear_block_butler $XX   
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0