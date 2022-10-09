#!/bin/bash
reservation_info () {
    echo "Reservation Info"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript exclusive_reservation get_by_id "[{$1,$2}]."
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get exclusive_reservation Info</title>'
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
echo "Type Coordinates on which you want to check( For ex:- If barcode is 032.054 then X-> 54 and Y-> 32"
echo "<br>"
  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>X_Coordinate</TD><TD><input type="number" name="X_Coordinate" size=12></td></tr>'\
	  '<tr><td>Y_Coordinate</TD><TD><input type="number" name="Y_Coordinate" size=12></td></tr>'\
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
     YY=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){2}.*/\2/'`
	      
     echo "X_Coordinate: " $XX
     echo '<br>'
     echo "Y_Coordinate: " $YY
     echo '<br>'
     reservation_info $XX $YY
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
