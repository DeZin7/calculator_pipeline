#!/bin/bash
response=$(curl -sk http://localhost:8765/sum\?a\=1\&b\=2)
echo "Response: $response"
if [ "$response" = "3" ]; then
    echo "Test passed!"
else
    echo "Test failed!"
fi