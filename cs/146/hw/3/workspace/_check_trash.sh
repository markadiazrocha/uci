#!/bin/sh
#echo $TRASH

homedir=~
#echo "homedir: $homedir"

user=$( whoami )
trashcan_path="$homedir/trashcan/"
export trashcan_path
flag=false # flag to determine if trashcan path exists: false (exists) true (DNE)
#echo $trashcan_path

# Frst check if $TRASH is non-null
if [ -n "$TRASH" ]; then
	# Then check if the path in $TRASH is a valid dir
	# If it is then set trashcan_path var to $TRASH
	if [ -d "$TRASH" ]; then
		#trashcan_path=$TRASH
		#flag=false
		if [ -d "$trashcan_path" ]; then
			echo "ALERT: TRASH has been specified: $TRASH; prevous srm trash designation: $"$trashcan_path" will be removed; all srm'd files will be moved to new TRASH location: $TRASH"
			mv "$trashcan_path/"* $TRASH 2> /dev/null
			rm -rf "$trashcan_path/"
		fi
		trashcan_path=$TRASH

	elif [ -d "$trashcan_path" ]; then
		: #flag=false
	else
		# if $TRASH or trashcan_path do not exist yet the make trashcan_path dir
		flag=true
	fi
elif [ -d "$trashcan_path" ]; then
	: #flag=false
else
	flag=true
fi

if [ "$flag" == true ]; then
	echo "ALERT: TRASH var not set. Creating directory $trashcan_path for srm trash designation"
	mkdir $trashcan_path
fi

