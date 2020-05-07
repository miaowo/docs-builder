#! /bin/bash

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing

output=deploy

main() {

mkdir $output 2> /dev/null
mkDocsDir

cp -r ./build_resources/lib/{css,fonts,js,icons} "$output"/
cp ./build_resources/{favicon.ico,index.html} "$output"/

while read LINE
do
	display_name=$(echo "$LINE" | cut -f1 -d":")
	dir_name=$(echo "$LINE" | cut -f2 -d":")

	# Anything starts with `#` or space will be ignored

	firstChar() {
	echo "$LINE" | cut -c 1
	}
	if [[ "$(firstChar)" != '#' && "$(firstChar)" != ' ' ]]; then
	      	buildDocs
	fi

done < build_resources/name.list
}

mkDocsDir() {

while read LINE
do
	  dir_name=$(echo "$LINE" | cut -f2 -d":")
	  mkdir -p "$output"/docs/"$dir_name"
done < build_resources/name.list
}

buildDocs() {

	echo "$display_name" '->' "$dir_name"

	# Render SECTION_CONTENT

	# It's hard to use shell variable inside a inline awk program, 
	# therefore we have to use `cd` here.

	dir=$(pwd)
	cd "$output"/docs/"$dir_name" || exit

	"$dir"/build_resources/bin/Markdown.pl \
		"$dir"/source/"$dir_name"/"$dir_name".md > tmp.snip

	awk '{ if ( /SECTION_CONTENT/ )\
	       	{ while(( getline line<"tmp.snip") > 0) \
			{ print line } } \
	       else { print $0 }}' \
		       < "$dir"/build_resources/template.html \
		       > index.html && rm tmp.snip

	# Render DISPLAY_NAME
	sed -i -e "s/DISPLAY_NAME/$display_name/g" index.html

	# Add mdui-list-item-active class to selected item
	sed -i -e 's|<a href="../'$dir_name'" class="mdui-list-item mdui-ripple">|<a href="../"$dir_name"" class="mdui-list-item mdui-ripple mdui-list-item-active">|g' index.html

        cd "$dir" || exit
	
}



main

