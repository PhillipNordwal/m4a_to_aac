#!/usr/bin/env sh

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$*"
readonly NUMARGS="$#"

has_avconv() {
	if [ ! -f `which avconv` ]
	then
		echo "avconv is not present"
		usage && exit 1
	fi
}

usage() {
	cat <<- EOF
	usage: $PROGNAME path_to_file.m4a

	Program uses avconv to copy out the aac to a file to path_to_file.aac.
	This will make it playable on the VW Golf Sound system.
	EOF
}

has_avconv

if [ ! 1 -eq $NUMARGS ]
then
	echo "wrong number of arguments are present"
	usage && exit 2
fi

file=$1
dir=`dirname "$file"`
base=`basename "$file" .m4a`

echo 
echo $file
echo

if [ ! -f "$file" ]
then
	echo "file is not present"
	usage && exit 3
fi

avconv -i "$file" -acodec copy "$dir/$base.aac"
