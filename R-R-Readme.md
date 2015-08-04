---
title: "M-M-Markdown"
author: "Robert Hadow"
date: "August 4, 2015"
output: html_document
---

This is an R Markdown document created in RStudio. You can look yourself at
```
https://github.com/roberthadow/DST-test.git
```

I have found the cave under the lake and slain Grendel's dam.

![Grendel's Dam](./figures/grendels_dam.jpg)

### Lessons learned:

If you use the git bash shell
```
 git config --list
```
is your friend. Make sure you include the full url, like this:
```
 git config --local remote.origin.url https://github.com/roberthadow/DST-test.git
```
If you are using Windows and you don't install git, github, and RStudio in order,
make sure you point RStudio to: (don't use sh.exe) 
```
 C:/Program Files/Git/bin/git.exe
```
If you are using the git bash shell in Windows, modify the shortcut on your desktop
to point to your working directory.  properties > Start in:

Here is proof I actuallly did this.

![RStudio Screenshot](./figures/ProofOfRstudio.png)

