#!/bin/bash

export PATH=/opt/homebrew/bin:"$PATH"

if [ -f /var/run/wireguard/wg0.name ]; then
    wg-quick down wg0
fi
wg-quick up wg0
