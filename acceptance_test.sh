#!/bin/bash
response=$(curl http://172.18.0.3:8765/sum\?a\=1\&b\=2)
echo "Response: $response"
if [ "$response" = "3" ]; then
    echo "Test passed!"
else
    echo "Test failed!"
fi