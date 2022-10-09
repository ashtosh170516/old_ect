#!/bin/bash
unblock_slot () {
    echo "Unblock all Slots which are put block due to space_not_available exception"
    sudo /opt/butler_server/bin/butler_server rpcterms butler_test_functions free_all_put_blocked_slot
    echo "<br>"
    echo "Done"      
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Unblock put block slots</title>'
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

unblock_slot
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0