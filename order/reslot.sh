#!/bin/bash
file_name=`ls -tr /home/sodimac/reslotting | grep "xlsx" | tail -n 1` 
cd /home/sodimac/reslotting && /usr/local/bin/python3.8 /home/sodimac/reslotting/inv_reslotting.py "$file_name" > /tmp/bhar.txt 2>&1
