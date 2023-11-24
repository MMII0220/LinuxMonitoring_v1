#!/bin/bash

OS=$(uname -rs)
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
IP=$(hostname -i)

function print_timezone() {
	local timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')
	if [ $(date +"%:z" | awk '{split($0,a,":"); print a[1]}' | cut -c2) == "0" ]; then
	  timezone="$timezone UTC $(date +"%:z" | awk '{split($0,a,""); print a[1]""a[3]}')"
	else
	  timezone="$timezone UTC $(date +"%:z" | awk '{split($0,a,":"); print a[1]}')"
	fi
	echo "${timezone}"
}

function print_netmask() {
	local netmask=$(ifconfig | grep 'inet ' | awk '{print $4}' | head -n 1)
	echo "${netmask}"
}

function print_gateway() {
    local gateway=$(ip r show default | awk '{print $3}')
    echo "${gateway}"
}

function print_ramTotal() {
    local ram_total=$(grep -i 'memtotal' /proc/meminfo | awk '{printf($2/1024/1024);}')
    echo "$ram_total GB"
}

function print_ram_used() {
	local ram=$(free | awk '/Mem:/ {printf("%.3f", $3/1024/1024);}')
	echo "${ram} GB"
}

function print_ram_free() {
	local ram=$(free | awk '/Mem:/ {printf("%.3f", $4/1024/1024);}')
	echo "${ram} GB"
}

function print_space_root() {
	local space=$(df -BM / | awk 'NR==2 {print $2}' | sed 's/M//')
	echo "${space} MB"
}

function print_space_root_used() {
	local space=$(df -BM / | awk 'NR==2 {print $3}'  | sed 's/M//')
	echo "${space} MB"
}

function print_space_root_free() {
	local space=$(df -BM / | awk 'NR==2 {print $4}' | sed 's/M//')
	echo "${space} MB"
}

function out() {
    printf  "\e[${background_type};${font_type}mHOSTNAME = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$HOSTNAME"
    printf  "\e[${background_type};${font_type}mTIMEZONE = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_timezone)"
    printf  "\e[${background_type};${font_type}mUSER = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$USER"
    printf  "\e[${background_type};${font_type}mOS = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_os)"
    printf  "\e[${background_type};${font_type}mDATE = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$DATE"
    printf  "\e[${background_type};${font_type}mHOSTNAME = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$HOSTNAME"
    printf  "\e[${background_type};${font_type}mUPTIME = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$UPTIME"
    printf  "\e[${background_type};${font_type}mUPTIME_SEC = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$UPTIME_SEC"
    printf  "\e[${background_type};${font_type}mIP = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_ip)"
    printf  "\e[${background_type};${font_type}mMASK = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_netmask)"
    printf  "\e[${background_type};${font_type}mGATEWAY = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_gateway)"
    printf  "\e[${background_type};${font_type}mRAM_TOTAL = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_ram_total)"
    printf  "\e[${background_type};${font_type}mRAM_USED = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_ram_used)"
    printf  "\e[${background_type};${font_type}mRAM_FREE = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_ram_free)"
    printf  "\e[${background_type};${font_type}mSPACE_ROOT = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_space_root)"
    printf  "\e[${background_type};${font_type}mSPACE_ROOT_USED = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_space_root_used)"
    printf  "\e[${background_type};${font_type}mSPACE_ROOT_FREE = \e[0m\e[${background_value};${font_value}m%s\e[0m\n" "$(print_space_root_free)"
}
