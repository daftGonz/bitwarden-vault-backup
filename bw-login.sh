#!/usr/bin/env bash

# Alpine startup script example that uses 'expect' to automate input
/usr/bin/expect << EOF
   spawn bw login --apikey
   expect "client_id\r"
   send "$CLIENT_ID\r"
   expect client_secret\r"
   send "$CLIENT_SECRET\r"
   expect eof
EOF