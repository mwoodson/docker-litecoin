#!/bin/bash

if type -P podman &> /dev/null
then
	DOCKERCMD=$(type -P podman)
else
	DOCKERCMD=$(type -P docker)
fi

$DOCKERCMD run --name litecoin                 \
           -p 7870:7879                                     \
           -e NAME=litecoin -e IMAGE=litecoin                   \
           -v /etc/localtime:/etc/localtime:ro              \
           -ti \
	       --rm \
           litecoin bash
