#!/bin/bash

registry=""

if [ $# -eq 1 ];  then
	registry=$1
else 
	echo "[$0] ERROR!! Invalid argument count"
	echo "[$0] [Usage] $0 192.168.6.110:5000"
	exit 1
fi

image_num=$(cat imagelist | wc -l)
echo "[$0] Pull ${image_num} images & Save as tar files & Push to ${registry}"

mkdir ./images

i=1
cat imagelist | while read line
do
	echo "[$0] [ ${i} / ${image_num} ] $line"
	sudo docker pull $line
	sudo docker tag $line ${registry}/$line
	sudo docker save $line > ./images/${i}.tar
	sudo docker push ${registry}/$line
	let i+=1
done

echo "[$0] Done"
