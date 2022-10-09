#!/bin/bash
put_block_slot () {
    echo "All Slots which are put block due to space_not_available exception"
    echo "<br>"
    echo "<br>"
    echo "Slots, Time, Put Order"
    sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript butler_test_functions generate_put_blocked_report "[]."
    echo "<br>"
    echo '<pre>'
    while read -r line; do
          echo -e '\n' $line
    done < /home/gor/space_not_avail.csv 
    echo '</pre>'        
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get put block slot report</title>'
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

put_block_slot
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0