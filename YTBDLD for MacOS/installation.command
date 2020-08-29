#!/bin/bash
# For Mac OS

if ! xcode-select -v ; then
    xcode-select --install
fi

# Install homebrew
if brew -v ; then
    brew update
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install Python3
if ! python3 --version ; then
    brew install python3
fi

# Install youtube-dl
if youtube-dl --version ; then
    youtube-dl --update
else
    brew install youtube-dl
fi

# Install FFmpeg
if ! ffmpeg -version ; then
    brew install ffmpeg
fi

# Authorized YouTubeDownloader.command to excute
BASEDIR=$(dirname "$0")
chmod 755 "$BASEDIR"/YouTubeDownloader.command

echo "Finished!"

$SHELL