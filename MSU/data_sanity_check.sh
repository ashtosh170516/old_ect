#!/bin/bash
data_sanity_check () {
    echo "Checking Data sanity "
    echo "<br>"
    data_sanity=`sudo /opt/butler_server/bin/butler_server rpcterms data_sanity_check check_complete_data_sanity`
    data_domain=`sudo /opt/butler_server/bin/butler_server rpcterms data_domain_validation_functions validate_all_tables true.`
    echo "Data Sanity: $data_sanity"
    echo "<br>"
    echo "Data domain validate all table: $data_domain"
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Checking data sanity</title>'
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

data_sanity_check
     
echo '</div>'
echo '</body>'
echo '</html>'

exit 0
