#!/usr/bin/env sh

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$*"
readonly NUMARGS="$#"
readonly CMD=

has_aac_to_ogg() {
	if [ ! -f ./aac_to_ogg.sh ]
	then
		echo "./aac_to_ogg.sh is not present"
		usage && exit 1
	fi
}

usage() {
	cat <<- EOF
	usage: $PROGNAME path_to_music_dir

	Program uses aac_to_ogg.sh to make create ogg's recursively for all aac's in
	dir. This will make them playable on the VW Golf Sound system.
	EOF
}

has_aac_to_ogg

if [ ! 1 -eq $NUMARGS ]
then
	echo "wrong number of arguments are present"
	usage && exit 2
fi

dir=$1

if [ ! -d "$dir" ]
then
	echo "dir is not present"
	usage && exit 3
fi

find "$dir" -regex ".*\.aac" -exec ./aac_to_ogg.sh {} \;
