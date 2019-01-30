#!/bin/sh

# Get script directory path
# will ONLY work if the last component of the path used to find the script is not a symlink
#mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mydir=$(dirname $(readlink -f $0))

# load variables ( ONLY WORKS IF lsrm.sh and _check_trash.sh are in same dir )
source "$mydir/_check_trash.sh"
#echo $trashcan_path

if [ "$#" -gt 0 ]; then
	echo "ERROR: command does NOT take arguments"
else
	ls -lF "$trashcan_path/" 2> /dev/null
fi

if [ $? -ne 0 ]; then
	echo "ERROR: make sure the path to your trashcan path is correctly defined and exists"
fi
