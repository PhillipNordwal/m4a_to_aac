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
	usage: $PROGNAME path_to_file.aac

	Program uses avconv to transcode an aac file to an ogg at path_to_file.ogg.
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
base=`basename "$file" .aac`

echo 
echo $file
echo

if [ ! -f "$file" ]
then
	echo "file is not present"
	usage && exit 3
fi

avconv -i "$file" -acodec libvorbis -aq 60 -vn -ac 2 "$dir/$base.ogg"
