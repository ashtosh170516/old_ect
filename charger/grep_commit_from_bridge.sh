#!/bin/bash
source /home/gor/easy_console/variable.sh
sshpass -p  "$PASSWORD_OF_BRIDGE"  ssh -o StrictHostKeyChecking=no -t $USERNAME@$BRIDGE_IP "cd /home/gor/embd_logs/charger;./test.sh" > /tmp/bhar.txt
