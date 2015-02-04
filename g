# !/bin/sh
# 2015/01/18
# @author: Shojiro Shibayama
# @desc: define generate command

split(){
	# $ split TEXT DELIMITER
	# ex) split "2015-01-18" "-"
	# -> returns array "2015", "01", "18"
	# use ${arr[0]} for "2015", and so on.
	TEXT=$1
	arr=( `echo $TEXT | tr -s $2 ' '`)
}

print_template(){
	# print template into each file
	# the expected input is: EXPERIMENT, SCRIPT.
	AUTHOR="Shojiro Shibayama"
	echo "%%% $1 %%%"
	date +"% %Y/%m/%d"
	echo "% @author: $AUTHOR"
	echo "% @desc:"
	if [ "$1" == "EXPERIMENT" ] ; then
		echo "rehash;clear all;close all;"
		echo "load_constants"
		echo "DirName = util.setResultDir(mfilename);"
	fi
}

if [ "$1" == "lib" ] ; then
	mkdir -p $PWD/libs/+$2
	echo $PWD/libs/+$2 is generated!
elif [ "$1" == "script" ] ; then
	# define file path first
	fp=$PWD/scripts/$2.m
	print_template SCRIPT >> $fp
elif [ "$1" == "exp" ] ; then
	# define file path first
	split $2 "/"
	if [ "" == "${arr[1]}" ] ; then
		fp=$(date +"$PWD/experiments/exp%Y_%m_%d_$2.m")
		echo "the file is generated under experiments directory."
	else
		mkdir -p experiments/"${arr[0]}"
		fp=$(date +"$PWD/experiments/${arr[0]}/exp%Y_%m_%d_${arr[1]}.m")
		echo "the file is generated under experiments/${arr[0]} directory."
	fi
	print_template EXPERIMENT >> $fp
elif [ "$1" == "model" ] ; then
	split $2 "/"
	if [ "" == "${arr[1]}" ] ; then
		echo "type the package name!"
		echo "ex) Test/LinearIOT"
	else
		fp=$PWD/libs/+${arr[0]}/${arr[1]}.m
		mkdir -p $PWD/libs/+${arr[0]}
		echo classdef ${arr[1]} < handle >> $fp
		echo "	properties(SetAccess = private)" >> $fp
		echo "		% define properties by yourself." >> $fp
		echo "	end" >> $fp
		echo "	properties(SetAccess=public, GetAccess=public)" >> $fp
		echo "		% define properties by yourself." >> $fp
		echo "	end" >> $fp
		echo >> $fp
		echo "	methods" >> $fp
		echo "		function output = sampleFunc(input)" >> $fp
		echo "			% define matlab function here" >> $fp
		echo "		end" >> $fp
		echo "	end% end instance methods" >> $fp
		echo >> $fp
		echo "	methods(Static)" >> $fp
		echo "		function output = sampleFunc(input)" >> $fp
		echo "			% define matlab function here" >> $fp
		echo "		end" >> $fp
		echo "	end% end class methods" >> $fp
		echo "end% end classdef" >> $fp
		echo "Successfully generated!"
	fi

else
	echo "!!! say sth as arguments !!!"
	echo "	The syntax is..."
	echo "		g lib DIRECTORY_NAME"
	echo "		g script SCRIPT_NAME"
	echo "		g exp EXPERIMENT_NAME"
	echo "		g exp EXPERIMENT_TYPE/EXPERIMENT_NAME"
	echo "		g model MODEL_NAME"
	echo "		g commands are available in /e/Shibayama/IOT-Develop"
fi
