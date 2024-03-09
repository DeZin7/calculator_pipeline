#!/bin/bash
response=$(curl -s localhost:2376/sum?a=1&b=2)
if [ "$response" -eq 3 ]; then
    echo "Test passed!"
else
    echo "Test failed!"
fi