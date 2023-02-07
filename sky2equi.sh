#!/bin/bash

if [ "$#" -lt "7" ] || [ "$#" -gt "8" ] ; then
	echo "usage: 		 ./sky2equi.sh <front> <back> <right> <left> <top> <bottom> <equirectangular> [<width>]"
	echo "e.g: 		./sky2equi.sh f.jpg b.jpg r.jpg l.jpg t.jpg b.jpg equi.jpg"
	echo "		./sky2equi.sh f.jpg b.jpg r.jpg l.jpg t.jpg b.jpg equi.jpg 4096"
	exit 0
fi

if [ -f "$7" ]; then
	echo "$7 already exists"
	exit 0
fi

if [ "$#" -eq "7" ] ; then
	WIDTH_SRC0=$(identify "$1"  | awk ' { print $3; } ' | awk -F x ' { print $1; } ')
	let "WIDTH = $WIDTH_SRC0 * 4"
else
	WIDTH=$8
fi

let "HEIGHT = $WIDTH / 2"

if [ "$HEIGHT" -lt "100" ] || [ "$HEIGHT" -gt "100000" ] ; then
	echo "size out of range"
	exit 0
fi

R_NUM=$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]$[ RANDOM % 10 ]
TMPS_PATH="/dev/shm/skyequi-tmpfiles"$R_NUM".bmp"
TMPD_PATH="/dev/shm/skyequi-tmpfiled"$R_NUM".bmp"
TMPJ_PATH="/dev/shm/skyequi-tmpfiled"$R_NUM".jpg"

montage "$4" "$3" "$5" "$6" "$1" "$2" -tile 6x1 -geometry x+0+0 "$TMPS_PATH"

ffmpeg -i "$TMPS_PATH" -vf v360=c6x1:equirect:w=$WIDTH:h=$HEIGHT "$TMPD_PATH"

rm "$TMPS_PATH"

convert "$TMPD_PATH" -quality 100 "$TMPJ_PATH"

rm "$TMPD_PATH"

exiftool -overwrite_original -UsePanoramaViewer=True -ProjectionType=equirectangular -PoseHeadingDegrees=180.0 -CroppedAreaLeftPixels=0 -FullPanoWidthPixels=$WIDTH -CroppedAreaImageHeightPixels=$HEIGHT -FullPanoHeightPixels=$HEIGHT -CroppedAreaImageWidthPixels=$WIDTH -CroppedAreaTopPixels=0 -LargestValidInteriorRectLeft=0 -LargestValidInteriorRectTop=0 -LargestValidInteriorRectWidth=$WIDTH -LargestValidInteriorRectHeight=$HEIGHT -Model="github fdd4s" "$TMPJ_PATH"

mv "$TMPJ_PATH" "$7"

echo "$7 created"
echo "Support future improvements of this software https://www.buymeacoffee.com/fdd4s";

