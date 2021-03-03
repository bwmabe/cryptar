#!/usr/bin/env bash

# Moves $# into the global variable space
ARGC=$#

print_usage () {
	echo "usage: cryptar.sh COMMAND [ARGS...]"
	echo "    decrypt: cryptar.sh dec FILE [DEST]"
	echo "    encrypt: cryptar.sh enc ARCHIVE_NAME FILE_1 [FILE_2, ... FILE_N]"
	echo "    list   : cryptar.sh ls FILE"
	exit 1
}

# decrypts a gpg-encrypted tar archive
decrypt () {
	if [ $ARGC -lt 2 ]
	then
		echo "decrypt: cryptar.sh dec FILE [DEST]"
		exit 1
	fi

	# The destination argument is optional
	if [ $ARGC -lt 3 ]
	then
		# destination is the current dir
		gpg -d $2 | tar -xzvf -
	else
		# otherwise, the destination is the 3rd argument
		# mkdir -p in case the destinaiton directory doesn't exist
		mkdir -p $3
		gpg -d $2 | tar -xzvf - -C $3
	fi
}

# encrypts a list files and stores them in a gpg encrypt tar
encrypt () {
	if [ $ARGC -lt 3 ]
	then
		echo "encrypt: cryptar.sh enc ARCHIVE_NAME FILE_1 [FILE_2, ... FILE_N]"
		exit 1
	fi

	# The filename should be the 2nd argument
	local ARCHIVE_NAME=$2

	# left shift ARGV twice to remove the 1st two arguments
	# ex:  command - cryptar enc arc.tar.gz.gpg file1 file2 file3
	#      args    - enc arc.tar.gz.gpg file1 file2 file3
	# shift once   - arc.tar.gz.gpg file1 file2 file3
	# shift twice  - file1 file2 file3
	shift; shift

	tar -cvzf - $@ | gpg --symmetric --cipher-algo aes256 -o $ARCHIVE_NAME
}

list_contents () {
	if [ $ARGC -lt 2 ]
	then
		echo "list: cryptar.sh ls FILE"
		exit 1
	fi

	gpg -d $2 | tar -tzvf -
}

if [ $ARGC -lt 1 ]
then
	print_usage
fi

case "$1" in
	dec)
		decrypt $@
		;;
	enc)
		encrypt $@
		;;
	ls)
		list_contents $@
		;;
	*)
		print_usage
		exit 1
esac



