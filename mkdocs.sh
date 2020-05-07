#! /bin/bash

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing

output="$1"

mkInitDocs() {

	final_html="$output"/docs/"$dir_name"/index.html

	echo -n '中文名：' 
	echo "$display_name"

	echo -n '目录名：' 
	echo "$dir_name"
	
	cp build_resources/template.html  "$final_html"

	sed -i -e "s/DISPLAY_NAME/$display_name/g" "$final_html"

	# Add mdui-list-item-active class to selected item

	sed -i -e 's|<a href="../'$dir_name'" class="mdui-list-item mdui-ripple">|<a href="../'$dir_name'" class="mdui-list-item mdui-ripple mdui-list-item-active">|g' "$final_html" 

}

firstChar() {
	
	echo "$i" | cut -c 1 
}


main() {

cp -r ./build_resources/lib/{css,fonts,js,icons} "$output"/

for i in $(cat < build_resources/name.list); do

	display_name=$(echo "$i" | cut -f1 -d":")
	dir_name=$(echo "$i" | cut -f2 -d":")

	# Anything starts with `#` is comment
	if [[ "$(firstChar)" != '#' ]]; then
	      	mkInitDocs
	fi
done
}

main

