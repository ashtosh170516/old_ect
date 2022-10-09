#!/bin/bash
ods_excluded () {
    barcode_validation=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript gridinfo search_by "[[{'barcode', 'equal', \""$1"\"}], 'key']." | grep -oP '\[\K[^\]]+'`
    echo "<br>"
    echo "Your given barcode coordinate is: $1"
    echo "<br>"
    echo "ODS Excluded"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript ods_excluded create_or_update "[{\""$1"\",$2},{'ods_excluded',{\""$1"\",$2},'true'},[]]." 
    echo '</pre>'
    echo "<br>"
    echo "<br>"   
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>ODS excluded</title>'
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
echo "In Lifted_state type 1 if msu is lifted up state else type 0"
echo "<br>"
  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
      '<tr><td>Barcode</TD><TD><input type="text" name="Barcode" size=12></td></tr>'\
      '<tr><td>Direction</TD><TD><input type="number" name="Direction" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*Barcode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
#     YY=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){4}.*/\2/'`
     YY=`echo "$QUERY_STRING" | sed -n 's/^.*Direction=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`     
     echo "Barcode: " $XX
     echo '<br>'
     echo "Direction: " $YY
     echo '<br>'

     ods_excluded $XX $YY
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
