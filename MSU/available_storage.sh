#!/bin/bash
available_storage () {
    echo "All available storable location"
    echo "<br>"
    sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript storage_info search_by "[[{'status', 'equal', 'available'}], 'record']."
    echo "<br>"
    echo "DONE"
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Remove Order</title>'
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
available_storage
echo '</div>'
echo '</body>'
echo '</html>'

exit 0