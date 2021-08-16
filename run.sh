#!/usr/bin/env bash

cssIds=" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ_"
i=0

echo -n '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="850" viewBox="0 0 850 48" xml:space="preserve">'

for image in img/* 
do
	echo -n '<image width="48" height="48"'
	if (($i > 0)) 
	then
		echo -n ' id="'
		echo -n ${cssIds:$i:1}
		echo -n '"'
	fi
	echo -n ' href="https://raw.githubusercontent.com/romdotdog/readme-scroller/main/'
	echo -n $image
	echo -n '"/>'
	((i++))
done

echo '<style>@keyframes scroll {0 {transform: translateX(0)} to {transform: translateX(850px)}}image {position: absolute;top: 0;left: 0;transform: translateX(-24px);animation: scroll 10s linear infinite;}'

for ((j=1; j<i; j++))
do
	echo -n "#"
	echo -n ${cssIds:$j:1}
	echo -n '{animation-delay: -'
	echo -n $(($j * 10000 / $i))
	echo -n 'ms}'
done

echo -n '</style></svg>'
