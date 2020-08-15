# YouTubeDownloader
An application for batch downloading videos from YouTube 

A lot of people trying to download 1080p or 4k videos from YouTube end up geting a silent video. That is because YouTube now codes the video and the audio seperately for anything over 720P. (That is also the reason why many online youtube downloading website that used to support 1080p downloading only support 720p now.)

This project is based on:

- [youtube-dl](https://ytdl-org.github.io/youtube-dl/). A powerful command-line program for downloading videos from YouTue and a few more website.

- [FFmpeg](https://ffmpeg.org/). A complete, cross-platform program to record, convert and stream audio & video.

- **Tkinter**. The standard Python interface to the Tk GUI toolkit





## Installation

### For macOS

#### Install  Apple’s Xcode package

Paste this line in Terminal and follow the prompt instruction to install Xcode

``````bash
$ xcode-select --install
``````



#### Install HomeBrew

Paste this line in Terminal and execute 

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

To confirm Homebrew installed correctly, run this command:

```bash
$ brew doctor
```

You'll see this result (or a higher version) if HomeBrew has been installed successfully

```Your system is ready to brew.```



#### Install Python 3

Paste this line in Terminal and execute 

```bash
$ brew install python3
```

Now let’s confirm which version was installed. Paste this line in Terminal and execute 

```shell
$ python3 --version
```

You'll see this result (or a higher version) if python3 has been installed successfully

```Python 3.7.4```



#### Install youtube-dl

Paste this line in Terminal and execute 

```bash
$ brew install youtube-dl
```



#### Install FFmpeg

Paste this line in Terminal and execute 

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