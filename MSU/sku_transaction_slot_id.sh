#!/bin/bash
sku_transaction_slot_id () {
    echo "<br>"
    echo "SKU transactions against Slot Id: $1"
    echo '<pre>'
    sudo -u postgres psql -U postgres -d butler_dev -c "select * from inventory_transaction_archives where slot = '$1' AND time > '$2' AND time < '$3' order by time desc"
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Getting Inventory transactions against any Slot Id</title>'
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
          '<tr><td>Slot_ID</TD><TD><input type="text" name="Slot_ID" ></td></tr>'\
          '<tr><td>From_time</TD><TD><input type="date" name="From_time" ></td></tr>'\
          '<tr><td>To_time</TD><TD><input type="date" name="To_time" ></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*Slot_ID=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
	   YY=`echo "$QUERY_STRING" | sed -n 's/^.*From_time=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     ZZ=`echo "$QUERY_STRING" | sed -n 's/^.*To_time=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
  
     echo "Slot_ID: " $XX
     echo '<br>'
     echo "From_time: " $YY
     echo '<br>'
     echo "To_time: " $ZZ
     echo '<br>'
     sku_transaction_slot_id $XX $YY $ZZ
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
