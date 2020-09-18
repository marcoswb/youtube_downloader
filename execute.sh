#! /bin/bash

init() {
    LINK_PLAYLIST=https://www.youtube.com/playlist?list=PL1U-W-oJ5W8cZy3gvcN8ZTSJsELX3LY5W
    rm ./input/*.*
    rm ./output/*.*
    rm ./temp/*.*
    youtube-dl -j --flat-playlist $LINK_PLAYLIST | jq -r '.id' | sed 's_^_https://youtu.be/_' > ./input/music_list_links.txt
}

download() {
    while read line
    do
    youtube-dl -f mp4 -o "~/Github/youtube_downloader/temp/%(title)s.%(ext)s" $line
    done < ./input/music_list_links.txt
}

list_files() {
    cd ./temp
    ls -1 ./*.mp4 > ./music_list_temp.txt

    while read line
    do
    SIZE=${#line}
    SIZE_MP4=4
    POSITION=$(($SIZE-$SIZE_MP4))
    echo ${line:0:POSITION} >> ./music_list.txt
    done < ./music_list_temp.txt
}

convert() {
    while read line
    do
    ffmpeg -nostdin -i "$line.mp4" "$line.mp3"
    done < ./music_list.txt
}

finish() {
    mv ./*.mp3 ../output
    rm ./*.*
}

init
download
list_files
convert
finish