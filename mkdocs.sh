#! /bin/bash

mkInitDocs() {

	display_name=$1 
	dir_name=$2

	echo -n '中文：' 
	echo $display_name

	echo -n '目录：' 
	echo $dir_name

}

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbingi


for i in $(cat < dirname.list); do
	display_name=$(echo "$i" | cut -f1 -d":")
	dir_name=$(echo "$i" | cut -f2 -d":")
	mkInitDocs $display_name $dir_name
done



