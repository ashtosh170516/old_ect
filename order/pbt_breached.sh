#!/bin/bash
breach_order () {
    echo "No. of PBT breached orders"
    echo "<br>"
    echo '<pre>'   
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript pps_orderlines print_pbt_summary_without_pending_inventory "[]."
    echo '</pre>'
    echo "<br>"
    echo "<br>"
    echo "<br>"
    echo "Breach Order details:"
    echo '<pre>'
    echo "External_id, PBT_Status, PBT, Created_time, Order_status "
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/order/pbt_breach_report.escript
    echo '</pre>'
    echo "<br>"
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>PBT breach order</title>'
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
breach_order
echo '</div>'
echo '</body>'
echo '</html>'

exit 0