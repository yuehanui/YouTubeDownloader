#! /usr/bin/env python3

from tkinter import *
from tkinter import filedialog 
import tkinter.messagebox
import os
import subprocess
import time


FORMAT_LIST=["134","135","136","247","137","271","248","313","272","302","298","299","303",
"308","315","401","272","571","402","334","335","336","337"]

class YTBDLD(Tk):
    def __init__(self):
        #locate to current path
        realpath = os.path.split(os.path.realpath(__file__))[0] + "/"
        os.chdir(realpath)

        
        Tk.__init__(self)
        self.title("YouTube Downloader")
        self.geometry('1000x800')
        self.mainFrame = Frame(self,padx=30,pady=10)
        self.entryLabel = self.createEntryLabel()
        self.entryLink = self.createEntryLink()
        self.formatButton = self.createFormatButton()
        self.directDownloadButton = self.createDirectDownloadButton()
        self.formatLabel = self.createFormatLabel()
        self.formatBox = self.createFormatBox()
        self.downloadSelectedButton = self.createDownloadSelectedButton()
        self.displayWin = self.createDisplayWin()
        self.availableFormat = []
        self.mainFrame.grid()


    def createEntryLabel(self):
        aLabel = Label(self.mainFrame,text ='Enter Video Link:',anchor='nw',)
        aLabel.grid(row=0,sticky=W,padx=5, pady=5)
        return aLabel

    def createEntryLink(self):
        aEntry =  Entry(self.mainFrame,width = 99, highlightbackground="grey")
        aEntry.grid(row=1,column=0,columnspan=2,padx=5)
        return aEntry

    # create showFormat button
    def createFormatButton(self):
        aButton = Button(self.mainFrame, text="Show Available Formats",
            command=self.requestFormat,
            width=25)
        aButton.grid(row=2,column=0,pady=5)
        return aButton

    # create download button
    def createDirectDownloadButton(self):
        aButton = Button(self.mainFrame, text="Download Best Resolution",
            command=self.download,
            width = 25)
        aButton.grid(row=2,column=1,pady=5)
        return aButton

    def createFormatLabel(self):
        aLabel = Label(self.mainFrame,text ='Formats:',anchor='nw',)
        aLabel.grid(row=3,sticky=W,padx=5, pady=5)
        return aLabel

    def createFormatBox(self):
        aListbox = Listbox(self.mainFrame,width=100,height=15)

        aListbox.grid(row=4,column=0, columnspan=2,padx=5)
        return aListbox

    def createDownloadSelectedButton(self):
        aButton = Button(self.mainFrame, text="Download Selected",
            command=self.downloadSelected,
            width = 25)
        aButton.grid(row=5,column=1,pady=5)
        return aButton

    def createDisplayWin(self):
        aText = Text(self.mainFrame, height = 25,width=128,highlightbackground
            ="#EFEFEF")
        aText.grid(row=6,column=0, columnspan=2,padx=5, pady=15)
        return aText

    def requestFormat(self):
        link = self.entryLink.get()
        if (link==""):
            tkinter.messagebox.showwarning('Info','Please enter a link!')
            return

        self.printToDisplay('Requesting formats...')
        
        global FormatDict
        self.availableFormat = []
        self.formatBox.delete(0,'end')
        
        command = ['youtube-dl', '--list-format',link]
        f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        
        # pass the shell output
        for o in iter(f.stdout):
         
            theFormat = o.split()
            if (theFormat[0] in FORMAT_LIST):
                resolution = theFormat[3]
                if (theFormat[4] == 'HDR'):
                    resolution += " HDR"

                volumn = theFormat[-1]
                volumn = volumn[:-2] + volumn[-1:]

                self.availableFormat.append([theFormat[0],resolution,volumn])
                self.printToFormatBox("{0:30} {1:30}".format(resolution,volumn))
               
                        
        noError = True
        for e in iter(f.stderr):
            self.processError(e)
            noError = False
    
        if (noError and len(self.availableFormat) == 0):
            self.printToDisplay("ERROR: Failed to capture video, check the URL entered.\n")


    def downloadSelected(self):
        select = self.formatBox.curselection()
        if (len(select)==0):
            tkinter.messagebox.showwarning('Info','No format is selected!')
        else:
            index = select[0]
            self.download(self.availableFormat[index][0])


    def download(self, format='bestvideo'):
        link = self.entryLink.get()
        if (link==""):
            tkinter.messagebox.showwarning('Info','Please enter a link!')
            return

        command = ['youtube-dl', '-i',link, '-f', f'{format}+140', '--merge-output-format', 'mp4']
        f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        
        # pass every 1 of 10 to the display window
        count=0
        for o in iter(f.stdout):
            if count % 10 ==0:
                self.printToDisplay(o)
            count += 1

        # if error found, print error
        for e in iter(f.stderr):
            self.processError(e)
         
        # print the 'finished' messge
        self.printToDisplay("Finished!")


    def printToDisplay(self,msg):
        self.displayWin.insert('end', f"{msg}\n")
        self.displayWin.see('end')
        self.displayWin.update()


    def printToFormatBox(self,msg):
        self.formatBox.insert('end', msg)
        self.formatBox.see('end')
        self.formatBox.update()


    def processError(self,e):
        print(e)
        if ('ERROR: Unable to download webpage' in e):
            self.printToDisplay('ERROR: Unable to download webpage. Check your Internet Connection and the URL entered\n')
        elif ('is not a valid URL' in e):
            self.printToDisplay('ERROR: The URL entered is invaild or unsupported.\n')
        else:
            self.printToDisplay(e)


downloader = YTBDLD()
downloader.mainloop()