#!/bin/bash
source /home/gor/easy_console/variable.sh
sshpass -p "$PASSWORD_OF_PLATFORM_DB" ssh -t $USERNAME@$PLATFORM_DB_IP "/home/gor/easy_console/rollcage_update.sh $1" > /tmp/bhar.txt