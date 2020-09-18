#! /bin/bash

init() {
    rm ./temp/*.*
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