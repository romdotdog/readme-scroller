#!/usr/bin/env bash

if (($# < 1))
then
	echo "error: must provide a duration in seconds" >&2
	exit 1
fi

i=0
echo -n '<svg id="_" version="1.1" xmlns="http://www.w3.org/2000/svg" width="850" viewBox="0 0 850 48" xml:space="preserve">'

for image in img/* 
do
	echo -n '<g'
	if (($i > 0)) 
	then
		echo -n ' id="Z_'
		echo -n $i
		echo -n '"'
	fi
	echo -n ">"
	cat $image | sed 's/<svg/<svg width="48" height="48"/'
	echo -n "</g>"	
	((i++))
done

((m = ${1-0} * 1000 / $i))

echo -n '<style>@keyframes scroll{0{transform:translateX(0)}to{transform:translateX(850px)}}#_>g{position:absolute;top:0;left:0;transform:translateX(-48px);animation:scroll '
echo -n ${1-0}
echo -n 's linear infinite}'

for ((j = 1; j < i; j++))
do
	echo -n "#_>#Z_"
	echo -n $j
	echo -n '{animation-delay:-'
	echo -n $(($j * $m))
	echo -n 'ms}'
done

echo -n '</style></svg>'
