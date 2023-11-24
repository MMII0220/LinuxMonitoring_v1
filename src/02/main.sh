#!/bin/bash

source ./func.sh  # calling another bash script here

if [[ $# -ne 0 ]]; then  # check for parameter
    echo "Script without parameter only!"
    exit 1
fi

function out() {  # main function
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = Russia/Moscow UTC -5"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "IP = $IP"
    echo "MASK = $(print_netmask)"
    echo "GATEWAY = $(print_gateway)"
    echo "RAM_TOTAL = $(print_ramTotal)"
    echo "RAM_USED = $(print_ram_used)"
    echo "RAM_FREE = $(print_ram_free)"
    echo "SPACE_ROOT = $(print_space_root)"
    echo "SPACE_ROOT_USED = $(print_space_root_used)"
    echo "SPACE_ROOT_FREE = $(print_space_root_free)"
}

out  # called a function

read -p "Store the Data in a file [Y/N]: " choice  # adding ing choice var bool value

if [ "${choice}" == 'Y' ] || [ "${choice}" == 'y' ]; then
    fileName="$(date +'%d_%m_%y_%H_%M_%S').status"
    {
        out  # calling out function
    } >"${fileName}"  # saving every data in out file
    echo "Data saved in: ${fileName}"
else
    echo "Data not saved"
fi

exit 0
