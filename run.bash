#!/bin/bash

password=$(cat credentials/secret.json | jq -r '.password')
server=10.0.0.1
script_dir=$(dirname $(readlink -f $0))
connect_script="${script_dir}/connect.bash"


date +"%Y-%m-%d %H:%M:%S Checking connection to ${server}"
if ! ping -c 1 -t 10 "${server}" > /dev/null 2>&1; then
    echo "disconnected"
    echo "${password}" | sudo -S  "${connect_script}" 2>&1
else
    echo "connected"    
fi
