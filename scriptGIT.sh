#!/bin/bash
declare -a IGNORE=('data' 'data2' 'data3');


for i in "${#IGNORE[@]}"
do
	if [$IGNORE[@] -ne $IGNORE[@] ]; then

	echo "${IGNORE[i]}" >> /home/luigi/VMC/.gitignore

	fi
done

cd FOLDER[]/home/luigi/VMC/



