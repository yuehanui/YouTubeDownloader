#! /usr/bin/env python3

from tkinter import *
from tkinter import filedialog 
import os
import subprocess
import time

FormatDict = {
    "134":"360p",
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
class YTBDLD(Tk):



    def __init__(self):
        #locate to current path
        realpath = os.path.split(os.path.realpath(__file__))[0] + "/"
        os.chdir(realpath)
        # create root window
        Tk.__init__(self)
        self.title("videos batch operation视频批量操作")
        self.geometry('1000x800')

        self.entryLabel = self.createEntryLabel()
        self.entryLink = self.createEntryLink()
        self.formatButton = self.createFormatButton()
        self.directDownloadButton = self.createDirectDownloadButton()
        self.formatBox = self.createFormatBox()
        self.displayWin = self.createDisplayWin()
        self.availableFormat = []

        

    def createEntryLabel(self):
        aLabel = Label(self,text ='Enter Links:',anchor='nw',)
        aLabel.grid(row=0,sticky=W,padx=5, pady=5)
        return aLabel

    def createEntryLink(self):
        aEntry =  Entry(self,width = 100, highlightbackground="grey")
        aEntry.grid(row=1,column=0,columnspan=2,padx=5, pady=5)
        return aEntry

    # create showFormat button
    def createFormatButton(self):
        aButton = Button(self, text="Show Available Formats",
            command=lambda:self.requestFormat(),
            width=25)
        aButton.grid(row=2,column=0,pady=5)
        return aButton

    # create download button
    def createDirectDownloadButton(self):
        aButton = Button(self, text="Download Highest Resolution",
            command=lambda:download(entry_link,displayWin),
            width = 25)
        aButton.grid(row=2,column=1,pady=5)
        return aButton

    def createFormatBox(self):
        aListbox = Listbox(self,width=100)
        aListbox.grid(row=4,column=0, columnspan=2,padx=5, pady=5)
        return aListbox

    def createDisplayWin(self):
        aText = Text(self, height = 25,width=114,highlightbackground
            ="#EFEFEF")
        aText.grid(row=5,column=0, columnspan=2,padx=5, pady=5)
        return aText

    def requestFormat(self):
        global FormatDict
        self.availableFormat = []
        link = self.entryLink.get()
        command = ['youtube-dl', '--list-format',link]
        f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        
        # pass the shell output
        for o in iter(f.stdout):
            theFormat = o.split()
            if (theFormat[0] in FormatDict):
                resolution = FormatDict.get(theFormat[0])
                volumn = theFormat[-1]
                self.availableFormat.append([theFormat[0],resolution,volumn])
                self.formatBox.insert('end',"{0:40} {1}".format(resolution,volumn))
                self.formatBox.see('end')
                self.formatBox.update();
        # if 1080p isn't find, try 720p
        for e in iter(f.stderr):
            self.formatBox.insert('end',"Error")
            self.formatBox.see('end')
            self.formatBox.update();

downloader = YTBDLD()
downloader.mainloop()