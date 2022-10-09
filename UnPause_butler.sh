#!/bin/bash
Unpause_Butler () {
    bot_ip=`sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butlerinfo get_by_id "[$1]." | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    echo "Butler Ip: $bot_ip"
    echo "<br>" 
    if [ ! -n "$bot_ip" ]
    then
        echo "Wrong Butler ID"
    else
        ping -c1 -W 1 $bot_ip   >/dev/null
        if [ $? -eq 0 ]; then
            sudo /opt/butler_server/erts-11.1.1/bin/escript /usr/lib/cgi-bin/rpc_call.escript butler_functions butler_unpause_manual "[$1]."
            echo "<br>"
            echo "OK Done...."
        else
           echo "Butler is not ON.....turn on Butler FIRST"
        fi
    fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Unpause a Butler</title>'
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
          '<tr><td>Butler_ID</TD><TD><input type="number" name="Butler_ID" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/'`
     
     echo "Butler_ID: " $XX
     echo '<br>'
     Unpause_Butler $XX 
     
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0

