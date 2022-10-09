#!/bin/bash
all_empty_bin () {
    echo "These all Bins are Empty as per order manager"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript order_manager get_min_free_ppsbins_list "[]."
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>All Empty Bin in System</title>'
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

all_empty_bin   
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
