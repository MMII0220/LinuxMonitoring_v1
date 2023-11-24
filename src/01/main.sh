#!/bin/bash

if [[ "$1" =~ [0-9] ]]; then
    echo "Invalid Input"
    exit 1
elif [ -z "$1" ] || [ $# -ne 1 ]; then
    echo "Invalid Input"
    exit 1
else
    echo "$1"
fi

exit 0

