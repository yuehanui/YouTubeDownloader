#! /usr/bin/env python3

from tkinter import *
from tkinter import filedialog 
import os
import subprocess
import time

FORMAT_2160P60 = "315+140"
FORMAT_2160P = "313+140"
FORMAT_1440P60 = "308+140"
FORMAT_1440P = "271+140"
FORMAT_1080P60 = "299+140"
FORMAT_1080P = "137+140"
FORMAT_720P = "136+140"
FORMAT_720P60 = "298+140"
FORMAT_480P = "135+140"

FormatDict = {
    "135":"480p",
    "136":"720p",
    "137":"1080p",
    "271":"1440p",
    "313":"2160p",

    "298":"720p60",
    "308":"1440p60",
    "299":"1080p60",
    "315":"2160p60",

    "334":"720p HDR",
    "335":"1080p HDR",
    "336":"1440p HDR",
    "337":"2160p HDR"
}

# create menu
def createMenu():
   
    menuFrame = Frame(root)
    
    menuFrame.pack()


# Create the content of the download page
def createDownloadPage():
    global downloadFrame

    downloadFrame = Frame(root,pady=10)
    # create link input field
    entryFrame = Frame(downloadFrame,pady=10)
    entryLabel = Label(entryFrame,text ='Enter Links:', width=88,anchor='nw',).pack()
    entry_link = Entry(entryFrame,width = 100, highlightbackground="grey",  
    )
    entry_link.pack()
    entryFrame.pack()

    # create showFormat button
    buttonFrame = Frame(downloadFrame,pady=10)
    Button(buttonFrame, text="Show Available Formats",command=lambda:requestFormat(entry_link,displayWin),width = 79
    ).pack()
    buttonFrame.pack()

    # create download button
    buttonFrame = Frame(downloadFrame,pady=10)
    Button(buttonFrame, text="Download",command=lambda:download(entry_link,displayWin),width = 79
    ).pack()
    buttonFrame.pack()


    # create output window
    displayFrame = Frame(downloadFrame,pady=10)
    displayWin = Text(displayFrame, height = 25,width=100,highlightbackground="#EFEFEF")
    displayWin.pack()
    displayFrame.pack()




def runCommandGetOutput(command,displayWin):
    f = subprocess.Popen(command,shell=True,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    for o in iter(f.stdout):
            displayWin.insert('end',o)
            displayWin.see('end')
            displayWin.update();

def requestFormat(entry_link,displayWin):
    global FormatDict
    availableFormat = []
    link = entry_link.get()
    print(link)
    command = ['youtube-dl', '--list-format',link]
    f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    # pass the shell output
    for o in iter(f.stdout):
        theFormat = o.split()
        if (theFormat[0] in FormatDict):
            availableFormat.append([theFormat[0],FormatDict.get(theFormat[0]),theFormat[-1]])

        displayWin.insert('end',o)
        displayWin.see('end')
        displayWin.update();
    # if 1080p isn't find, try 720p
    for e in iter(f.stderr):
        displayWin.insert('end',e)
        displayWin.see('end')
        displayWin.update();
    print(availableFormat)

# input: links of videos
# This function called youtbe-dl in shell to download the videos
def download(entry_links,displayWin):
    links = entry_links.get(1.0, END).split("\n");
    links = links[:len(links)-1]

    #download

    #try downloading 1080p
    videoCode = FORMAT_1080P
    i = 0
    while i < len(links):
        link = links[i]
        i += 1;
        
        command = ['youtube-dl', '-i',link, '-f', videoCode, '--merge-output-format', 'mp4']
        # reset resolution
        videoCode = FORMAT_1080P
        
        f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        
        # pass the shell output
        for o in iter(f.stdout):
      
            displayWin.insert('end',o)
            displayWin.see('end')
            displayWin.update();
        # if 1080p isn't find, try 720p
        for e in iter(f.stderr):
            displayWin.insert('end',"can't find 1080p version, trying lower resulution")
            displayWin.see('end')
            displayWin.update();
            i -= 1
            videoCode=FORMAT_720P

    # print the 'finshed' messge
    displayWin.insert('end',"\nFinished")
    displayWin.see('end')
    displayWin.update()




#locate to current path
realpath = os.path.split(os.path.realpath(__file__))[0] + "/"
os.chdir(realpath)

# create root window
root = Tk()
root.title("videos batch operation视频批量操作")
root.geometry('1000x800')

# 1 = 下载, 2 = 合并
curStateCode = 1

# aButton=下载; bButton=合并
createMenu()

downloadFrame = Frame(root,pady=10)
createDownloadPage()
downloadFrame.pack()



mainloop()


