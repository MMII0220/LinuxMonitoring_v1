#!/bin/bash

source ./func.sh

timer=$(date +%s.%N)

if [ $# -eq 0 ]; then
	echo "Error: path not found"
	exit 1
fi

if [[ $# -gt 1 ]]; then
    echo "Script runs with one parameter"
    exit 1
fi

path_to_directory=$1

if [ ! -d "$path_to_directory" ]; then
	echo "Error: directory '$path_to_directory' not found"
	exit 1
fi

if [ "${path_to_directory: -1}" != "/" ]; then
	echo "Error: the path must end with '/'"
	exit 1
fi

out  # calling function

timer_end=$(date +%s.%N)
total_time=$(echo "$timer_end" - "$timer" | bc)
echo "Script execution time (in seconds) = $total_time"
