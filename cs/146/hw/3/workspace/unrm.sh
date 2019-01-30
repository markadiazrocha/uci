#!/bin/sh

if [ "$#" -eq 0 ]; then
	echo "ERROR: need to specify file(s) and/or directory(s)"
else
	# will ONLY work if the last component of the path used to find the script is not a symlink
	#mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	#restored_dir="$mydir/restored"

	# will work with symlink
	mydir=$(dirname $(readlink -f $0))
	curwd=$(pwd)
	restored_dir="$curwd/restored" # designates a directory (restored/) in the current-
								   # -working directory to be a folder for all unremoved-
								   # -files from trashcan

	# check to see if trashcan_path exists (ONLY WORKS IF srm.sh and _check_trash.sh are in same dir-
	# -and last path name is NOT symlink)
	source "$mydir/_check_trash.sh"
	
	mkdir $restored_dir 2> /dev/null
	
	# just a simple mv command to move files to restored/
	# If mv fails the error messages will be silenced
	for item in "$@"
	do
		mv "$trashcan_path/$item" $restored_dir 2> /dev/null
	done

	if [ $? -ne 0 ]; then
		echo "WARNING: some arguments could NOT be removed; make sure trashcan is not empty and that the specified argument(s) is/are filename(s) and/or dirname(s) that exist(s) in trashcan"
	fi
fi
