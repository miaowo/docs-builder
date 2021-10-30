#! /usr/bin/env bash

output=$1
IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing


for i in $(cat < name.list); do

	  dir_name=$(echo "$i" | cut -f2 -d":")
	  mkdir -p ../source/"$dir_name"
	  touch ../source/"$dir_name"/"$dir_name".md
	  touch ../source/"$dir_name"/"$dir_name".footer.html
done

