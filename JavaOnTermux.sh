#!/bin/bash

# Take filename as commandline argument
cmd_arg=$1

jar_android=/data/data/com.termux/files/usr/share/java/android.jar

if [[ "$cmd_arg" == *".java"* ]]
then		
	file_name=$1

	# Remove file extension
	file_name=$(echo "$file_name" | cut -f 1 -d '.')

	# Compile and Execute
	ecj $file_name.java || exit 1
	dx --dex --output=$file_name.dex $file_name.class
	dalvikvm -cp $jar_android:$file_name.dex $file_name ${@:2}

elif [ "$cmd_arg" == "install" ]
then
	apt update
	apt install ecj4.6 dx
else
	echo "Script to run Java on Android in Termux"
	echo "usage: bash JavaOnTermux.sh <option | source file>"
	echo "Possible options are listed below."
	echo "install: To install required packages"
fi
