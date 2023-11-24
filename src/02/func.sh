#!/bin/bash


OS=$(uname -rs)
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
IP=$(hostname -i)

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
