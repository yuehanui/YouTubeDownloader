#!/bin/bash
# for Linux

sudo apt-get update

#Install Python3
if ! python3 --version ; then
    apt-get install python3
fi

# Install youtube-dl
if ! youtube-dl --version ; then
    apt-get install youtube-dl
fi

# Install FFmpeg
if ! ffmpeg -version ; then
    apt-get install ffmpeg
fi

# Authorized YouTubeDownloader.command to excute
BASEDIR=$(dirname "$0")
chmod 755 "$BASEDIR"/YouTubeDownloader.command

echo "Finished!"

$SHELL