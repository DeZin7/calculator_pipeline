#!/bin/bash

set -x

NODE_IP=$(sudo k3s kubectl get nodes -o jsonpath='{ $.items[0].status.addresses[?(@.type=="ExternalIP")].address }')
NODE_PORT=$(sudo k3s kubectl get svc calculator-service -o=jsonpath='{.spec.ports[0].nodePort}')
./gradlew acceptanceTest -Dcalculator.url=http://${NODE_IP}:${NODE_PORT}



# response=$(curl http://172.18.0.3:8765/sum\?a\=1\&b\=2)
# echo "Response: $response"
# if [ "$response" = "3" ]; then
#     echo "Test passed!"
# else
#     echo "Test failed!"
# fi