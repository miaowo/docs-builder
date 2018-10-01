#! /bin/bash

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing

output="$1"

mkInitDocs() {


	echo -n '中文名：' 
	echo "$display_name"
	echo test > "$output"/"$dir_name"/index.html

	echo -n '目录名：' 
	echo "$dir_name"

}

firstChar() {
	
	echo "$i" | cut -c 1 
}

for i in $(cat < name.list); do

	display_name=$(echo "$i" | cut -f1 -d":")
	dir_name=$(echo "$i" | cut -f2 -d":")

	if [[ "$(firstChar)" != '#' ]]; then
	      	mkInitDocs
	fi
done



