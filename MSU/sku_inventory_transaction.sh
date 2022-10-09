#!/bin/bash
source /home/gor/easy_console/variable.sh
sku_transaction () {
    echo '<pre>'
    sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/get_item_uid.sh $1"
    echo '</pre>'
    product_uid=`sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/get_item_uid.sh $1" | head -3 | tail -1 | grep -o '[[:digit:]]*'`
    echo "<br>"
    echo "Internal Id for SKU is:" $product_uid
    echo "<br>"
    echo "SKU transactions"
    echo '<pre>'
    sudo -u postgres psql -U postgres -d butler_dev -c "select * from inventory_transaction_archives where item_id = ' $product_uid' AND time >= '$2' AND time <= '$3' order by time desc"
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Inventory transactions against any SKU</title>'
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
          '<tr><td>SKU_ID</TD><TD><input type="text" name="SKU_ID" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*SKU_ID=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
	   YY=`echo "$QUERY_STRING" | sed -n 's/^.*From_time=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     ZZ=`echo "$QUERY_STRING" | sed -n 's/^.*To_time=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
  
     echo "SKU_ID: " $XX
     echo '<br>'
     echo "From_time: " $YY
     echo '<br>'
     echo "To_time: " $ZZ
     echo '<br>'
     sku_transaction $XX $YY $ZZ
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
