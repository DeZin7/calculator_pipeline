#!/bin/bash
gateway_ip=$(ip route | awk '/default/ { print $3 }')
response=$(curl -s http://$gateway_ip:2376/sum\?a\=1\&b\=2)
echo "Response: $response"
if [ "$response" = "3" ]; then
    echo "Test passed!"
else
    echo "Test failed!"
fi