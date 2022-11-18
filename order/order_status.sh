#!/bin/bash
order_status () {
    echo "Order by status"
    echo "<br>"
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-9.3.3.6/bin/escript /usr/lib/cgi-bin/rpc_call.escript pps_orderlines order_node print_summary "[]."
    echo '</pre>'        
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Order by Status dashboard</title>'
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

order_status
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0