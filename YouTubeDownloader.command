#! /usr/bin/env python3

from tkinter import *
from tkinter import filedialog 
import os
import subprocess
import time


FORMAT_1080P = "137+140"
FORMAT_720P = "136+140"

# create menu
def createMenu():
   
    menuFrame = Frame(root)
    aButton = Button(menuFrame, text="download 下载",width=25,command=swith2Download,foreground="black")
    aButton.pack( side = 'left')

    bButton = Button(menuFrame, text="merge videos 合并视频",command=swith2Merge,width=25 )
    bButton.pack( side = 'left' )

    cButton = Button(menuFrame, text="download subtitle 下载字幕",width=25)
    cButton.pack( side = 'left' )

    dButton = Button(menuFrame, text="add subtitle to a video 添加字幕",width=25)
    dButton.pack( side = 'left' )
    menuFrame.pack()


#hide the current page content
def hideCurrFrame():
    global curStateCode
    if curStateCode == 1:
        global downloadFrame
        downloadFrame.pack_forget()
    elif curStateCode == 2:
        global mergeFrame
        mergeFrame.pack_forget()
# switch to download page
def swith2Download():
    global curStateCode
    global downloadFrame
    if curStateCode != 1:
        hideCurrFrame()
        downloadFrame.pack()
        
        curStateCode = 1

# switch to merge page
def swith2Merge():
    global curStateCode
    global mergeFrame
    if curStateCode != 2:
        hideCurrFrame()
        mergeFrame.pack()
        curStateCode = 2

# Create the content of the download page
def createDownloadPage():
    global downloadFrame

    downloadFrame = Frame(root,pady=10)
    # create link input field
    entryFrame = Frame(downloadFrame,pady=10)
    entryLabel = Label(entryFrame,text ='Enter Links:', width=88,anchor='nw',).pack()
    entry_links = Text(entryFrame,height = 25,width = 100, highlightbackground="grey",  
    )
    entry_links.pack()
    entryFrame.pack()

    # create download button
    buttonFrame = Frame(downloadFrame,pady=10)
    Button(buttonFrame, text="Download",command=lambda:download(entry_links,displayWin),width = 79
    ).pack()
    buttonFrame.pack()


    # create output window
    displayFrame = Frame(downloadFrame,pady=10)
    displayWin = Text(displayFrame, height = 25,width=100,highlightbackground="#EFEFEF")
    displayWin.pack()
    displayFrame.pack()


# Create the content of the download page
def createMergePage():
    global mergeFrame
    paths = []
    mergeFrame= Frame(root,pady=10)
    
    # create link input field
    entryFrame = Frame(mergeFrame,pady=10)

    selectLabel = Label(entryFrame,text ='Select files:', width=88,anchor='nw',).pack()
    # create select button
    Button(entryFrame, text="Select",command=lambda:selectPath(selectWin,paths),width = 20
    ).pack()
    selectWin = Text(entryFrame,height = 10,width = 100, highlightbackground="grey",  
    )
    selectWin.pack()
    
    

    entryFrame.pack()

    # create download button
    buttonFrame = Frame(mergeFrame,pady=10)
    Button(buttonFrame, text="Merge",command=lambda:merge(paths,displayWin),width = 79
    ).pack()
    buttonFrame.pack()


    # create output window
    displayFrame = Frame(mergeFrame,pady=10)
    displayWin = Text(displayFrame, height = 25,width=100,highlightbackground="#EFEFEF")
    displayWin.pack()
    displayFrame.pack()



    
def selectPath(window,paths):
    somePath = filedialog.askopenfilenames()
    for path in somePath:
        window.insert('end',path+"\n")
        window.see('end')
        window.update();
        paths.append(path);

#merge Vidos
def merge(paths,displayWin):
    for path in paths:
        if (not path.endswith('.mp4')):
            displayWin.insert('end',"video foramt must be .mp4")
            displayWin.update();
            exit()
    if len(paths)<2:
        displayWin.insert('end',"At least two videos\n")
        displayWin.update();
        exit()
        
    mergePaths = ""

    for path in paths:
        command = f'ffmpeg -i "{path}" -strict -2 -vf scale=-1:480 -vcodec copy -acodec copy -vbsf h264_mp4toannexb "{path}.ts"'
        mergePaths += path + '.ts|'
        runCommandGetOutput(command,displayWin)
    mergePaths = mergePaths[:-1]
    #合并
    os.system(f'ffmpeg -i "concat:{mergePaths}" -acodec copy -vcodec copy -absf aac_adtstoasc "output_.mp4"')

def runCommandGetOutput(command,displayWin):
    f = subprocess.Popen(command,shell=True,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    for o in iter(f.stdout):
            displayWin.insert('end',o)
            displayWin.see('end')
            displayWin.update();

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
mergeFrame = Frame(root,pady=10)
createDownloadPage()
createMergePage()
downloadFrame.pack()



mainloop()


