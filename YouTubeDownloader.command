#! /usr/bin/env python3

import tkinter as tk
import os
import time
import subprocess


# input: links of videos
# 下载视频
def download():
    links = entry_links.get(1.0, tk.END).split("\n");
    links = links[:len(links)-1]



    #download
    print(links)
    #1080p
    videoCode = "137+140"
    i = 0
    while i < len(links):
        link = links[i]
        i += 1;
        
        command = ['youtube-dl', '-i',link, '-f', videoCode, '--merge-output-format', 'mp4']
        # reset 分辨率
        videoCode = "137+140"
        
        f = subprocess.Popen(command,universal_newlines=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        
        #传递系统输出
        for o in iter(f.stdout):
            print(o)
            displayWin.insert('end',o)
            displayWin.see('end')
            displayWin.update();
        for e in iter(f.stderr):
            displayWin.insert('end',"can't find HD version, trying lower definition")
            displayWin.see('end')
            displayWin.update();
            i -= 1
            # 没有找到1080p则尝试720p
            videoCode='136+140'




    #打印结束信息
    displayWin.insert('end',"\nFinished")
    displayWin.see('end')
    displayWin.update()




#定位至当前路径
realpath = os.path.split(os.path.realpath(__file__))[0] + "/"
os.chdir(realpath)

#创建主窗口
root = tk.Tk()
root.title("视频批量操作")
root.geometry('1000x800')



#创建菜单栏
menuFrame = tk.Frame(root)
redbutton = tk.Button(menuFrame, text="Red",height=5,width=30,foreground="black")
redbutton.pack( side = 'left')

greenbutton = tk.Button(menuFrame, text="green",height=5,width=30 )
greenbutton.pack( side = 'left' )

bluebutton = tk.Button(menuFrame, text="Blue",height=5,width=30)
bluebutton.pack( side = 'left' )
menuFrame.pack()



#创建链接输入框
entryFrame = tk.Frame(root,pady=10)
entryLabel = tk.Label(entryFrame,text ='Enter Links:', width=78,anchor='nw',).pack()
entry_links = tk.Text(entryFrame,height = 25,width = 100, highlightbackground="grey",  
)
entry_links.pack()
entryFrame.pack()

#创建下载指令按钮
buttonFrame = tk.Frame(root,pady=10)
tk.Button(buttonFrame, text="Download",command=download,width = 79
).pack()
buttonFrame.pack()


#创建显示窗口
diplayFrame = tk.Frame(root,pady=10)
displayWin = tk.Text(diplayFrame, height = 25,width=100,highlightbackground="#EFEFEF")
displayWin.pack()
diplayFrame.pack()

tk.mainloop()


