#!/bin/bash

if [ "$#" -ne "3" ]; then
	echo "usage: ./resize_equi.sh <source image> <resized image> <new width>"
	echo "e.g ./resize_equi.sh pano.jpg pano2.jpg 4096"
	exit 0
fi

WIDTH_IMG=$3
let "HEIGHT_IMG = $WIDTH_IMG / 2"

convert "$1" -resize "$WIDTH_IMG"x"$HEIGHT_IMG" -quality 100 "$2"

exiftool -overwrite_original -UsePanoramaViewer=True -ProjectionType=equirectangular -PoseHeadingDegrees=180.0 -CroppedAreaLeftPixels=0 -FullPanoWidthPixels=$WIDTH_IMG -CroppedAreaImageHeightPixels=$HEIGHT_IMG -FullPanoHeightPixels=$HEIGHT_IMG -CroppedAreaImageWidthPixels=$WIDTH_IMG -CroppedAreaTopPixels=0 -LargestValidInteriorRectLeft=0 -LargestValidInteriorRectTop=0 -LargestValidInteriorRectWidth=$WIDTH_IMG -LargestValidInteriorRectHeight=$HEIGHT_IMG -Model="github fdd4s" "$2"
