#! /bin/bash

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbingi


for i in $(cat < dirname.list); do
	  mkdir /home/katzeilla/Git/miaowo-docs/docs/"$i"
	  touch /home/katzeilla/Git/miaowo-docs/docs/"$i"/index.html 
  done

