#!/usr/bin/env bash

GPG_TTY=($tty)
ARGC=$#

if [ $ARGC -lt 2 ]
then
	echo "usage: encypt.sh ARCHIVE_NAME FILE_1 [FILE_2, ... FILE_N]"
	exit 1
fi

ARCHIVE_NAME=$1

shift

tar -cvzf - $@ | gpg --symmetric --cipher-algo aes256 -o $ARCHIVE_NAME

