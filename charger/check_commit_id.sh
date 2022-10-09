#!/bin/bash
commit_id () {
    echo "Get commit id"
    sudo /usr/lib/cgi-bin/charger/grep_commit_from_bridge.sh
    echo "<br>"
    echo '<pre>'
    while read -r line; do
          echo -e '\n' $line
    done < /tmp/bhar.txt
    echo '</pre>'        
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Get COMMIT ID for all chargers</title>'
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

commit_id
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
