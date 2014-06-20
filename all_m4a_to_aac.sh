#!/usr/bin/env sh

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$*"
readonly NUMARGS="$#"
readonly CMD=

has_m4a_to_aac() {
	if [ ! -f ./m4a_to_aac.sh ]
	then
		echo "./m4a_to_aac.sh is not present"
		usage && exit 1
	fi
}

usage() {
	cat <<- EOF
	usage: $PROGNAME path_to_music_dir

	Program uses m4a_to_aac.sh to make create aac's recursively for all m4a's in
	dir. This will make them playable on the VW Golf Sound system.
	EOF
}

has_m4a_to_aac

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

find "$dir" -regex ".*\.m4a" -exec ./m4a_to_aac.sh {} \;
