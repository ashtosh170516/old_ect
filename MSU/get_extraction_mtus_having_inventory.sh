#!/bin/bash
get_extraction_mtus_having_inventory () {
    echo "Get extraction mtus having inventory"
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ims_mtu_functions get_extraction_mtus_having_inventory "[]."
    echo '</pre>'        
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get extraction mtus having inventory</title>'
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

get_extraction_mtus_having_inventory
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0