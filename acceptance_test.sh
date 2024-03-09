#!/bin/bash
response=$(curl https://172.18.0.1:2376/sum\?a\=1\&b\=2)
echo "Response: $response"
if [ "$response" = "3" ]; then
    echo "Test passed!"
else
    echo "Test failed!"
fi