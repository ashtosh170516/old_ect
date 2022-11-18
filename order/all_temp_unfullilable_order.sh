#!/bin/bash
all_temp_unfulfillable () {
    echo "All Temporary unfulfillable orders and their audit report "
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-9.3.3.6/bin/escript /usr/lib/cgi-bin/rpc_call.escript station_recovery get_temporary_unfulfillable_orders "['all']."
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get all temporary unfulfillable order report</title>'
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

all_temp_unfulfillable
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
