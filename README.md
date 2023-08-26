# skybox to equirectangular, a cube2sphere faster alternative

## What it does

script to map 6 skybox cubemap faces into an equirectangular projection with ffmpeg v360 filter. This script adds automatically exif tags of 360 equirectangular pano view, this allows to view the pano in viewers like Ricoh Theta https://play.google.com/store/apps/details?id=com.theta360&hl=en&gl=US  

the default size of equirectangular image result is 4 * (cube face width) width.  
height of equirectangular image is the half of width.  

`sky2equi.sh` is the main tool  

`mattersky2equi.sh` is a tool to simplify the conversion for matterport skybox downloaded with https://github.com/fdd4s/matterport-downloader  
e.g: to convert all skybox downloaded to a equirectangular:  

    $ ls -1 pan*skybox1*jpg | awk ' { print "\"" $0 "\""; } ' | xargs -n 1 ./mattersky2equi.sh  

(both sh scripts and skyboxs must be in the same folder)

`resize_equi.sh` is a tool to resize the equirectangular pano and set exif tags of the new size  

## Dependencies

imagemagick, ffmpeg, exiftool  

this code is designed to work over linux (as /dev/shm ram tmpfs)  

## Usage

    $ ./sky2equi.sh <front> <back> <right> <left> <top> <bottom> <equirectangular> [<width>]  

## Examples

    $ ./sky2equi.sh f.jpg b.jpg r.jpg l.jpg t.jpg b.jpg equi.jpg  
    $ ./sky2equi.sh f.jpg b.jpg r.jpg l.jpg t.jpg b.jpg equi.jpg 4096  

## Known issues

"montage-im6.q16: cache resources exhausted " can be resolved changing ImageMagick configuration, more info here: https://github.com/ImageMagick/ImageMagick/issues/396  

## Viewers

Android: Ricoh Theta App https://play.google.com/store/apps/details?id=com.theta360&hl=en&gl=US  

PC: Linux/Mac/Windows: Panini https://github.com/lazarus-pkgs/panini  

Web Browser: Chrome and Firefox: three.js (webgl based): https://github.com/pljhonglu/threejs-panorama https://threejs.org/examples/webgl_panorama_equirectangular.html  

## Youtube 360 slideshow video

Equirectangular panoramas can be uploaded to Youtube as a 360º video slideshow. It can be created using FFmpeg (like a normal slideshow of jpg images), add the tag to the video of 360º panoramic using "spatial-media" and upload to youtube where the slideshow video will be shown as a 360º video.  

https://github.com/FFmpeg/FFmpeg  
https://github.com/google/spatial-media  

## Credits

Created by fdd4s  
Send feedback and questions to fc1471789@gmail.com  
All files are public domain https://unlicense.org/  
