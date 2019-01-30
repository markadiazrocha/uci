#!/bin/sh

flag=false

# Check to see if no arguments passed
if [ $# -eq 0 ]
then
	ls -lSF
else
	# Check to see if any Directories or files were passed
	for arg in $@; do
		if [ -d $arg ]; then
			#echo "$arg is DIRECTORY"
			# set flag to true if a directory was passed
			flag=true
			break
		elif [ -f $arg ]; then
			flag=true
			break
		fi
	done
	
	# Checks to seee if the flag was set`
	if [ $flag == true ]; then
		#ls $@ -lSFd 2> /dev/null
		#ls $@ -lSd 2> /dev/null
		ls -lSd $@ 2> /dev/null # if flag == true include -d option so as to not descend dirs
	else
		#ls $@ -lSF 2> /dev/null
		#ls $@ -lS 2> /dev/null
		ls -lS $@ 2> /dev/null
	fi
fi

# Check to see if ls command failed
if [ $? -ne 0 ]
then
	echo "WARNING: some invalid arguments were passed"
fi
