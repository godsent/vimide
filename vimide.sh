#!/bin/sh
docker run --rm -it -v "$PWD:/home/editor/mnt/$PWD" -w "/home/editor/mnt/$PWD" vim:latest vim $@
