#!/bin/bash
source /home/gor/easy_console/variable.sh
sku_information () {
    echo '<pre>'
    sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/get_item_uid.sh $1"
    echo '</pre>'
    product_uid=`sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/get_item_uid.sh $1" | head -3 | tail -1 | grep -o '[[:digit:]]*'`
    echo "<br>"
    echo "Internal Id for SKU is:" $product_uid
    echo "<br>"
    if [ $product_uid -eq 0 ];then
       echo "Product doesn't exist in Databse"
    else
       echo "<br>"
       echo "Deleting SKU"
       echo "<br>"
       echo "Response:"
       echo "<br>"
       echo "<br>"
       echo '<pre>'
       response=`curl -I -X DELETE "http://$PLATFORM_CORE_IP:8080/api-gateway/mdm-service/wms-masterdata/item/$product_uid" -H "Content-Type: application/json"`
       echo "$response"
       echo '</pre>'
       new_product_uid=`sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/get_item_uid.sh $1" | head -3 | tail -1 | grep -o '[[:digit:]]*'`
       echo "<br>"
       echo "ID found after deletion:" $new_product_uid
       echo "<br>"
       if [ $new_product_uid -eq 0 ];then
          echo "Product deleted successfully"
       else
          echo "<br>"
          echo "Product is not deleted, something went wrong"
       fi
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Delete SKU</title>'
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
     echo "SKU_ID: " $XX
     echo '<br>'
     sku_information $XX 
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0


