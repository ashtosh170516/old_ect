#!/bin/bash
reslotting () {
    echo "<br>"
    if [ "$1" -eq "1" ]; then
      has_session=$(sudo tmux has-session -t reslotting 2>&1)
      if [ ! -n "$has_session" ]; then
          echo "<br>"
          echo "Reslotting is still going on, for checking status type 2 and Submit"
          echo "<br>"
      else
          echo "<br>"
          echo "No reslotting tmux session present"
          echo "<br>"
          echo "##################################################"
          echo "<br>"
          echo "Starting Script"
          echo "<br>"
          echo "##################################################"
          echo "<br>"
          sudo tmux new-session -d -s reslotting "sudo /usr/lib/cgi-bin/order/reslot.sh"
          echo "<br>"
          echo "##################################################"
          echo "<br>"
          echo "Tmux session started: reslotting"
          echo "<br>"
          echo "##################################################"
          echo "<br>"
      fi
    elif [ "$1" -eq "2" ]; then 
      echo "<br>"
      echo "##################################################"
      echo "<br>"
      echo "Logs Running"
      echo "<br>"
      echo "##################################################"
      echo "<br>"
      echo '<pre>'
      while read -r line; do
      echo -e '\n' $line
      done < /tmp/bhar.txt
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
echo '<title>Reslotting Order</title>'
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
          '<tr><td>Type 1 for trigger re-slotting and 2 for checking logs</TD><TD><input type="number" name="Type 1 for trigger re-slotting and 2 for checking logs" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*logs=\([^ ]*\).*$/\1/p'`
     echo '<br>'
     reslotting $XX   
     
  fi
echo '</div>'
echo '</body>'
echo '</html>'

exit 0