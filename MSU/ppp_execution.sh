#!/bin/bash
source /home/gor/easy_console/variable.sh
ppp_execution () {
    echo "All executions which are in Waiting state due to Invalid LPN scan:"
    echo "<br>"
    echo '<pre>'
    sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -o StrictHostKeyChecking=no -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/ppp_execution.sh"
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>PPP Waiting execution</title>'
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

ppp_execution   

echo '</div>'
echo '</body>'
echo '</html>'

exit 0

