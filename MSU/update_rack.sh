#!/bin/bash
Rack_position_update () {
    if [ "$4" -eq "1" ]; then
        echo "Make lift Down First by Doing NFS that Butler"
        echo "<br>"
    elif [ "$4" -eq "0" ]; then
        barcode_validation=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript gridinfo search_by "[[{'barcode', 'equal', \""$2"\"}], 'key']." | grep -oP '\[\K[^\]]+'`
        echo "<br>"
        echo "Your given barcode coordinate is: $2"
        echo "<br>"
        if [ ! -n "$barcode_validation" ]
        then
            echo "You have type wrong barcode"    
        else
            echo "Updating rack location"
            #sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript mhs_operation_utilities update_rack_position "[<<\"$1\">>,$3,\""$2"\", 'null']." 
           update=`curl -X POST -H 'Content-Type: application/json' -d '{"rack_id": "'"$1"'","rack_direction":'$3',"barcode": "'"$2"'","butler_id": null}' localhost:8181/api/send_updated_rack_position`
           echo "<br>"
           echo "Rack updated Done: $update"
           echo "<br>"
        fi    
    else
        echo "Please type correct lifted state "
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Update Rack Location</title>'
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
          '<tr><td>Rack_ID</TD><TD><input type="number" name="Rack_ID" size=12></td></tr>'\
      '<tr><td>Barcode</TD><TD><input type="text" name="Barcode" size=12></td></tr>'\
      '<tr><td>Direction</TD><TD><input type="number" name="Direction" size=12></td></tr>'\
      '<tr><td>Lifted_state</TD><TD><input type="number" name="Lifted_state" size=12></td></tr>'\
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
     YY=`echo "$QUERY_STRING" | sed -n 's/^.*Barcode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     ZZ=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){4}.*/\2/'`
     AA=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){5}.*/\2/'`
  
     echo "Rack_ID: " $XX
     echo '<br>'
     echo "Barcode: " $YY
     echo '<br>'
     echo "Direction: " $ZZ
     echo '<br>'
     echo "Lifted_state: " $AA
     echo '<br>'
     Rack_position_update $XX $YY $ZZ $AA
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
