#!/bin/bash

password=$(cat credentials/secret.json | jq -r '.password')
server=10.0.0.1

while true; do
    if ! ping -c 1 -t 10 "${server}" > /dev/null 2>&1; then
        echo "${password}" | sudo -S wg-quick down wg0
        echo "${password}" | sudo -S wg-quick up wg0
    else
        echo "Connected"
    fi
    sleep 10

done
myps -P 259 | sudo -S echo hello
