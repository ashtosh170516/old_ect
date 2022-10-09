#!/bin/bash
Purging_Butler () {
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butler_test_functions purge_butler "[$1]."
    echo "Purging Done for Butler $1...."
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Purging Butler</title>'
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
     

     Purging_Butler $XX 
     
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0

