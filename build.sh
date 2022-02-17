#!/usr/bin/bash

if type -P podman &> /dev/null
then
	DOCKERCMD=$(type -P podman)
else
	DOCKERCMD=$(type -P docker)
fi

$DOCKERCMD build $@ -t litecoin .
