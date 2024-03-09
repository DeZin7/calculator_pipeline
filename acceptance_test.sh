#!/bin/bash
test $(curl -s localhost:2376/sum?a=1\&b=2) -eq 3
