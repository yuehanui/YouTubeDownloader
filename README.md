# YouTubeDownloader


This is an application for downloading videos from YouTube in all available resolutions.

A lot of people trying to download 1080p or 4k videos from YouTube end up getting a silent video. The reason is that YouTube now codes the video and  audio seperately for anything over 720P. (That is also the reason why many online youtube downloading platform that used to support 1080p downloading only support 720p now.)

And most of the YouTube downloading platforms (both web-base and desktop app) that support 1080p+ suck. They either charge a fee or work at an intolerably slow speed.

This application allows you to download those videos at full speed and it is totally free from any subscription or Ad.



## Development

This project is based on:

- [youtube-dl](https://ytdl-org.github.io/youtube-dl/). A powerful command-line program for downloading videos from YouTue and a few more website.
- [FFmpeg](https://ffmpeg.org/). A complete, cross-platform program to record, convert and stream audio & video.
- **Tkinter**. Python‘s standard GUI toolkit

This application works by downloading the video and the audio saperately using **youtube-dl**, then using **FFmpeg** to merge the video and the audio. 



## Features

It support all available resolution such as 8K or 4K HDR 

You can either let the program automatically select the best format of a video for you. Or you can let it show all the formats available so you can make a choice.

The GUI of the program is very intuitive. If you can install it, you will easily find out how to use it.



## Installation

You need to install multiple command line programs since this application is built based on them. Most of these programs will be installed in between 30 seconds to 3 minutes.

**FFmpeg** will takes longer time to install (around 15 minutes. May varies on different Internet environment and computer config) since it is a powerful and versatile multimedia processor.

For anything that you have already installed on you compture, you can skip it.



### For macOS

#### Install  Apple’s Xcode package

Paste this line in Terminal and follow the prompt instruction to install Xcode

``````bash
$ xcode-select --install
``````



#### Install [HomeBrew](https://brew.sh/)

Paste this line in Terminal and execute 

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```



#### Install [Python3](https://www.python.org/)

Paste this line in Terminal and execute.

```bash
$ brew install python3
```



#### Install [youtube-dl](https://ytdl-org.github.io/youtube-dl/)

Paste this line in Terminal and execute.

```bash
$ brew install youtube-dl
```



#### Install [FFmpeg](https://ffmpeg.org/)

Paste this line in Terminal and execute. Then go get a coffee!

```bash
$ brew install ffmpeg
```



#### Clone this project to your computer

Paste this line in Terminal and execute 

``` bash
$ git clone https://github.com/yuehanui/YouTubeDownloader.git
```



#### Authorize the script to execute on your computer

Paste this line in Terminal, then drag the **YouTubeDownloader.command** file into the terminal. You will see that the path of the file is automatically appended to the end of the command. Press enter to execute.

```bash
 $ chmod 755 
```



Done!



## How 2 Use

Open **YouTubeDownloader.command**.