#! /bin/bash

output=$1
IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing


for i in $(cat < name.list); do

	  dir_name=$(echo "$i" | cut -f2 -d":")
	  mkdir "$output"/"$dir_name"
done

