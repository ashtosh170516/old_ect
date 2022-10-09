  #!/bin/bash
  correct_unprocessable () {
      echo "checking PPS : $1 and Bin : $2"
      echo "<br>"
      
      bin_status=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsbinrec get_ppsbin_status "[{$1,\""$2"\"}]." | cut -d' ' -f2-`
      if [ "$bin_status" == "sidelined" ]; then
        echo "Bin status is sidelined, please resume order from Tower/ Easy console"
        echo "<br>"
      elif [ "$bin_status" == "idle" ] || [ "$bin_status" == "in_use" ] ; then
        echo "Bin status is in idle or in_use"
        echo "<br>"
        echo "Checking processable flag for this bin"
        echo "<br>"
        flag_status=`sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsbin get_column_by_id "[{$1,\""$2"\"},'processable']." | sed 's/.*\[\([^]]*\)\].*/\1/g' | sed 's/^.*,//;s/}$//'`
        if [ "$flag_status" == true ]; then
          echo "Bin is already having processable as true"
          echo "<br>"
        elif [ "$flag_status" == false ]; then
          echo "Bin is having processable false, ppsbinrec is not having status sidelined".
          echo "<br>"
          echo "Clearing processable flag to resume bin"
          echo "<br>"
          echo '<pre>'
          sudo /opt/butler_server/erts-11.1.3/bin/escript /usr/lib/cgi-bin/rpc_call.escript ppsbin update_columns_by_id "[{$1,\""$2"\"},[{'processable','true'}]]."
          echo '</pre>'
        fi
      fi
  }
  echo "Content-type: text/html"
  echo ""

  echo '<html>'
  echo '<head>'
  echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
  echo '<title>Correct unprocessable bins</title>'
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
            '<tr><td>PPS_ID</TD><TD><input type="number" name="PPS_ID" size=12></td></tr>'\
  		  '<tr><td>BIN_ID</TD><TD><input type="number" name="BIN_ID" size=12></td></tr>'\
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
  	 YY=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){2}.*/\2/'`
  		
       echo "PPS_ID: " $XX
       echo '<br>'
  	   echo "BIN_ID: " $YY
       echo '<br>'
  	   correct_unprocessable $XX $YY
    fi
  echo '</div>'
  echo '</body>'
  echo '</html>'

  exit 0
