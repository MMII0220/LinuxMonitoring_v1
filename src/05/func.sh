#!/bin/bash


function print_num_of_folders() {
	local num_of_folders=$(find "$path_to_directory" -type d | wc -l)
	echo "${num_of_folders}"
}

function print_top5_folders() {
	local top5_folders=$(du -h "$path_to_directory"* | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}')
	echo "${top5_folders}"
}

function print_num_of_files() {
	local num_of_files=$(find "$path_to_directory" -type f | wc -l)
	echo "${num_of_files}"
}

function print_num_of_conf() {
	local num_of_conf=$(find "$path_to_directory" -type f -name "*.conf" | wc -l)
	echo "${num_of_conf}"
}

function print_num_of_txt() {
	local num_of_txt=$(find "$path_to_directory" -type f -name "*.txt" | wc -l)
	echo "${num_of_txt}"
}

function print_num_of_executables() {
	local num_of_executables=$(find "$path_to_directory" -type f -executable | wc -l)
	echo "${num_of_executables}"
}

function print_num_of_logs() {
	local num_of_logs=$(find "$path_to_directory" -type f -name "*.log" | wc -l)
	echo "${num_of_logs}"
}

function print_num_of_archives() {
	local num_of_archives=$(find "$path_to_directory" -type f \( -name "*.zip" -o -name "*.rar" -o -name "*.tar" -o -name "*.7z" -o -name "*.gz" \) | wc -l)
	echo "${num_of_archives}"
}

function print_num_of_symblinks() {
	local num_of_symblinks=$(find "$path_to_directory" -type l | wc -l)
	echo "${num_of_symblinks}"
}

function print_top10_files() {
	local top10_files=$(find "$path_to_directory" -type f -exec du -h {} + | sort -hr | sed -n '1,10'p | awk '{printf("%d - %s, %s, ", NR, $2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}')
	echo "${top10_files}"
}

function print_top10_executables() {
	local top10_executables=$(find "$path_to_directory" -type f -executable -exec du -h {} +| sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')
	echo "${top10_executables}"
}

function out() {
    echo "Total number of folders (including all nested ones) = $(print_num_of_folders)"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    echo "$(print_top5_folders)"
    echo "Total number of files = $(print_num_of_files)"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(print_num_of_conf)"
    echo "Text files = $(print_num_of_txt)"
    echo "Executable files = $(print_num_of_executables)"
    echo "Log files (with the extension .log) = $(print_num_of_logs)"
    echo "Archive files = $(print_num_of_archives)"
    echo "Symbolic links = $(print_num_of_symblinks)"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    echo "$(print_top10_files)"
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    echo "$(print_top10_executables)"
}