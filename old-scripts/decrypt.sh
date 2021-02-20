#!/usr/bin/env bash

ARGC=$#

if [ $ARGC -lt 1 ]
then
	echo "usage: decrypt.sh FILE [DEST]"
	exit 1
fi

if [ $ARGC -lt 2 ]
then
	gpg -d $1 | tar -xzvf -
else
	mkdir -p $2
	gpg -d $1 | tar -xzvf - -C $2
fi
	
