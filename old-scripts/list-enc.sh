#!/usr/bin/env bash

ARGC=$#

if [ $ARGC -lt 1 ]
then
	echo "usage: list-enc.sh FILE"
	exit 1
fi

gpg -d $1 | tar -tzvf -
