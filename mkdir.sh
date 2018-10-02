#! /bin/bash

output=$1
IFS=$'\n'       # make newlines the only separator
set -f          # disable globbingi


for i in $(cat < dirname.list); do
	  mkdir "$output"/"$i"
  done

