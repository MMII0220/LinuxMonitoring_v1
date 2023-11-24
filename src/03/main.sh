#!/bin/bash

source ./func.sh  # calling another bash script here

if [[ $# -ne 4 ]]; then  # only 4 parameters
    echo "Only 4 parameters"
    exit 1
fi

for i in {1..4}; do  # in parameters values must be among 1 to 6
    if ! [[ ${!i} =~ ^[1-6]$ ]]; then
        echo "Error: param should be number between 1 to 6"
        exit 1
    fi
done

if [ "${1}" == "${2}" ] || [ "${3}" == "${4}" ]; then  # font and bg of columns must be diff
    echo "Error: Font and Backgound of columns must be different"
    read -p "Do you want to run script with different parameters (Y/N): " choice
    if [ "${choice}" == 'Y' ] || [ "${choice}" == 'y' ]; then
        echo "<<Y>> was written in parameters"
        exit 1
    fi
    echo "<<N>> was written!"
    exit 1
fi

background_color_type=('47' '41' '42' '44' '45' '40')
font_color_type=('97' '91' '92' '94' '95' '90')
background_color_value=('47' '41' '42' '44' '45' '40')
font_color_value=('97' '91' '92' '94' '95' '90')

background_type=${background_color_type[$1 - 1]}
font_type=${font_color_type[$2 -1]}
background_value=${background_color_value[$3-1]}
font_value=${font_color_value[$4 - 1]}

out  # calling function

exit 0
