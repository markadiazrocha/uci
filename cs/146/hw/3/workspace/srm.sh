#!/bin/sh

# will ONLY work if the last component of the path used to find the script is not a symlink
#mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# will work with symlink
mydir=$(dirname $(readlink -f $0))

# check trashcan_path and load trashcan_path var 
#( ONLY WORKS IF srm.sh and _check_trash.sh are located in same dir )
source "$mydir/_check_trash.sh"

# just a simple mv command to move files to ...trashcan_path/
# If mv fais the error messages will be silenced
mv $@ "$trashcan_path/" 2> /dev/null

# Check to see mv command was succesful (much easier than filtering invalid arguments -
# -because built in mv command already does all the work)
# Print error if mv command failed.
if [ $? -ne 0 ]; then
	echo "ERROR: invalid arguments; make sure files exist and that any specified options are valid"
fi
