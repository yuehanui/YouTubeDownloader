#!/bin/bash
# for Linux

sudo apt-get update
#Install Python3, youtube-dl and FFmpeg
apt-get install python3
apt-get install youtube-dl
apt-get install ffmpeg

BASEDIR=$(dirname "$0")
chmod 755 "$BASEDIR"/YouTubeDownloader.command

echo "Finished!"

$SHELL