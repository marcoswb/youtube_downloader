#! /bin/bash

while read line
do
youtube-dl -o "~/Github/youtube_downloader/temp/%(title)s.%(ext)s" $line
done < ./input/musicas.txt