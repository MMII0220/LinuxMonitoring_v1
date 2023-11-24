#!/bin/bash

source ./func.sh

if [[ ! -f ./colorconfig.conf ]]; then
	echo "Error: Config file not found"
	exit 1
fi

if [[ $# -ne 0 ]]; then
	echo "Script must run without parameter"
	exit 1
fi

def_background=("6" "6")
def_font=("1" "1")

color_names=("white" "red" "green" "blue" "purple" "black")
background_color_type=('47' '41' '42' '44' '45' '40')
font_color_type=('97' '91' '92' '94' '95' '90')
background_color_value=('47' '41' '42' '44' '45' '40')
font_color_value=('97' '91' '92' '94' '95' '90')

column1_background=$(grep "^column1_background=" colorconfig.conf | cut -d "=" -f 2)
if [[ -z "$column1_background" ]]; then  # adding black by default if conf file parameter is empty
	column1_background=${def_background[0]}
	isdef_col1_bg=1
fi

column1_font_color=$(grep "^column1_font_color=" colorconfig.conf | cut -d "=" -f 2)
if [[ -z "$column1_font_color" ]]; then  # adding black by default if conf file parameter is empty
	column1_font_color=${def_font[0]}
	isdef_col1_font=1
fi

column2_background=$(grep "^column2_background=" colorconfig.conf | cut -d "=" -f 2)
if [[ -z "$column2_background" ]]; then  # adding black by default if conf file parameter is empty
	column2_background=${def_background[1]}
	isdef_col2_bg=1
fi

column2_font_color=$(grep "^column2_font_color=" colorconfig.conf | cut -d "=" -f 2)
if [[ -z "$column2_font_color" ]]; then  # adding black by default if conf file parameter is empty
	column2_font_color=${def_font[1]}
	isdef_col2_font=1
fi

if ! [[ $column1_background =~ ^[1-6]$ ]] || ! [[ $column1_font_color =~ ^[1-6]$ ]] ||
   ! [[ $column2_background =~ ^[1-6]$ ]] || ! [[ $column2_font_color =~ ^[1-6]$ ]]; then  # check 
   echo "Error: Param should be a number between 1 and 6"
   exit 1
fi

if [ "$column1_background" = "$column1_font_color" ] || [ "$column2_backgorund" = "$column2_font_color" ]; then
	echo "Error: Font and background of column must be different colors"
	exit 1
fi

background_type=${background_color_type[$column1_background - 1]}
font_type=${font_color_type[$column1_font_color - 1]}
background_value=${background_color_value[$column2_background - 1]}
font_value=${font_color_value[$column2_font_color - 1]}

if [[ -z "$isdef_col1_bg" ]]; then
	printf "Column 1 background = $column1_background (${color_names[$column1_background - 1]})\n"
else
	printf "Column 1 background = default (${color_names[$column1_background - 1]})\n"
fi

if [[ -z "$isdef_col1_font" ]]; then
	printf "Column 1 font color = $column1_font_color (${color_names[$column1_font_color - 1]})\n"
else
	printf "Column 1 font color = default (${color_names[$column1_font_color - 1]})\n"
fi

if [[ -z "$isdef_col2_bg" ]]; then
	printf "Column 2 background = $column2_background (${color_names[$column2_background - 1]})\n"
else
	printf "Column 2 background = default (${color_names[$column2_background - 1]})\n"
fi

if [[ -z "$isdef_col2_font" ]]; then
	printf "Column 2 font color = $column2_font_color (${color_names[$column2_font_color - 1]})\n"
else
	printf "Column 2 font color = default (${color_names[$column2_font_color - 1]})\n"
fi

out  # calling function

exit 0
