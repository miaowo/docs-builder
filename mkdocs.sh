#! /bin/bash

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing

output="$1"

main() {

mkDocsDir

cp -r ./build_resources/lib/{css,fonts,js,icons} "$output"/
cp ./build_resources/{favicon.ico,index.html} "$output"/

for i in $(cat < build_resources/name.list); do

	display_name=$(echo "$i" | cut -f1 -d":")
	dir_name=$(echo "$i" | cut -f2 -d":")

	# Anything starts with `#` will be ignored  
	if [[ "$(firstChar)" != '#' ]]; then
	      	buildDocs
	fi
done
}

buildDocs() {

	final_html="$output"/docs/"$dir_name"/index.html

	echo -n '中文名：' 
	echo "$display_name"

	echo -n '目录名：' 
	echo "$dir_name"
	
	cp build_resources/template.html  "$final_html"

	# Render DISPLAY_NAME
	sed -i -e "s/DISPLAY_NAME/$display_name/g" "$final_html"

	# Add mdui-list-item-active class to selected item
	sed -i -e 's|<a href="../'$dir_name'" class="mdui-list-item mdui-ripple">|<a href="../'\
		$dir_name'" class="mdui-list-item mdui-ripple mdui-list-item-active">|g'\
	       	"$final_html" 

}

firstChar() {
	
	echo "$i" | cut -c 1 
}


mkDocsDir() {

for i in $(cat < build_resources/name.list); do

	  dir_name=$(echo "$i" | cut -f2 -d":")
	  mkdir -p "$output"/docs/"$dir_name"
done

}

main

