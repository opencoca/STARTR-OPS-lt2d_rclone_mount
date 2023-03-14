#!/bin/bash

echo  'account='"$B2_ACCOUNT"
echo  'key='"$B2_KEY" 

printf '%s\n' \
    '[BackBlaze]' \
    'type = b2' \
    'account ='"$B2_ACCOUNT"\
    'key ='"$B2_KEY" \
    > /root/.config/rclone/rclone.conf

rclone mount BackBlaze: b2 --daemon

sleep 600
