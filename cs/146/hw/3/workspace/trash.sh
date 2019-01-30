#!/bin/sh

# Get script directory path
# will ONLY work if the last component of the path used to find the script is not a symlink
#mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mydir=$(dirname $(readlink -f $0))

# $trashcan_path defined and exported in _check_trash.sh
# check to see if trash exists ( ONLY WORKS IF lsrm.sh and _check_trash.sh are in same dir )
source "$mydir/_check_trash.sh"
#echo $trashcan_path

#if find "$trashcan_path" -mindepth 1 -print -quit | grep -q .; then
#	echo not empty, do something
#else
#	echo The directory $target is empty '(or non-existent)'
#fi

if [ "$#" -gt 0 ]; then
	echo "ERROR: command does NOT take arguments"
else
	if find "$trashcan_path/" -mindepth 1 -print -quit | grep -q .; then
		#echo "$trashcan_path/"*
		rm -rf "$trashcan_path/"* 2> /dev/null
	else
		#echo "trashcan_path: $trashcan_path"
		echo "ALERT: trashcan is empty"
	fi
fi

if [ $? -ne 0 ]; then
	echo "ERROR: make sure the path to your trashcan path is correctly defined and exists"
fi
