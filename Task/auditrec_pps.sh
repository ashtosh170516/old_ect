#!/bin/bash
auditrec_pps () {
    echo "All pending auditrec on PPS : $1"
    echo "<br>"
    if [ "$2" -eq "1" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'selected_pps', 'equal', [$1]},{'status', 'notequal', 'audit_completed'},{'status','notequal','audit_resolved'},{'status','notequal','audit_cancelled'},{'status','notequal','audit_reaudited'},{'status','notequal','audit_unprocessable'},{'status','notequal','audit_rejected'}], 'key']."
       echo '</pre>'
    elif [ "$2" -eq "2" ]; then
      echo '<pre>'
       sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript auditrec search_by "[[{'selected_pps', 'equal', [$1]},{'status', 'notequal', 'audit_completed'},{'status','notequal','audit_resolved'},{'status','notequal','audit_cancelled'},{'status','notequal','audit_reaudited'},{'status','notequal','audit_unprocessable'},{'status','notequal','audit_rejected'}], 'record']."
       echo '</pre>'
    else
        echo "Wrong key pressed"
    fi    
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Audit rec on PPS </title>'
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

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>PPS_id</TD><TD><input type="text" name="PPS_id" size=12></td></tr>'\
      '<tr><td>Type 1 for key and 2 for record</TD><TD><input type="number" name="Type 1 for key and 2 for record" size=12></td></tr>'\
      '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
   # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*PPS_id=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
   YY=`echo "$QUERY_STRING" | sed -n 's/^.*record=\([^ ]*\).*$/\1/p'`
  
     echo "PPS_id: " $XX
     echo '<br>'
     echo "Type 1 for key and 2 for record: " $YY
     echo '<br>'
     auditrec_pps $XX  $YY

 #auditline rec $XX $YY
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0