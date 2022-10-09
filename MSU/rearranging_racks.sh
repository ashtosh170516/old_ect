#!/bin/bash
rearranging_racks () {
    echo "Rack -rearrange as per popularity post mockput"
    echo "<br>"
    echo "<br>"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript  butler_test_functions test_rearrange_racks_for_best_put "[]."
    echo '</pre>'        
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Rack -rearrange as per popularity post mockput</title>'
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

rearranging_racks
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0