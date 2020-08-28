#!/bin/bash
# For Mac OS
xcode-select --install
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#Install Python3, youtube-dl and FFmpeg
brew install python3 youtube-dl ffmpeg

BASEDIR=$(dirname "$0")
chmod 755 "$BASEDIR"/YouTubeDownloader.command

echo "\nFinished!\n"

$SHELL