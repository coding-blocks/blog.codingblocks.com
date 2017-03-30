---
layout: post
title: "Setting up Sublime Text for Competitive Coding"
description: "Setting up Sublime Text for Competitive Coding" 
headline: "Setting up Sublime Text for Competitive Coding"
modified: 2017-03-26 14:40:42 +0530
category: 'Development Tips'
tags: [tutorial, 'sublime text', 'competitive coding']
feature-img: "img/post/sublime-text/featured_img.png"
author: Nikhil Kumar Singh
mathjax: 
chart: 
comments: true
featured: false
---

In this blog post, I am going to show you how you can setup Sublime Text editor for a "Competitive coding" friendly environment!

We will see how to do the task of **writing to stdin** and **reading from stdout** in a single window of Sublime Text! 

Also, you will not have to manually input in the terminal!

## 1. Install Sublime Text

If you do not have Sublime Text installed in your system, you can download it from [here](https://www.sublimetext.com/3).


## 2. Create necessary files

Now, we will require 3 basic files:


- A .cpp file (as I am going to use C++ programming language for writing code). In this example, I will name this file as **example.cpp** 
- **input.txt** (file on which we will write stdin)
- **output.txt** (file on which C++ program will write stdout)


## 3. Setting Layout

Now, its time to setup the layout of the Sublme Text window.
### Steps:


1. Open all the files we created in last step, i.e example.cpp, input.txt, output.txt.
2. Now, in menu bar, select *View -> Layout -> Columns: 3* . Alternatively, you can use keyboard shortcut **Shift+Alt+3**. As a result, window will get partitioned into 3 columns.
3. Now, we will try to fix input.txt and output.txt in a single column. For this, select *View -> Groups -> Max Columns: 2* . As a result, input.txt and output.txt will get stacked in a single column.

Here is how your Sublime Text Editor window should looks like now:
![](/img/post/sublime-text/screen.png){:class="img-responsive"}


## 4. Writing to stdin and reading from stdout

Now, we will have to write C++ code in such a way that it can read stdin from input.txt and write stdout to output.txt .

Here are the lines we need to add to main function of our C++ code:

```cpp
#ifndef ONLINE_JUDGE
    // for getting input from input.txt
    freopen("input.txt", "r", stdin);
    // for writing output to output.txt
    freopen("output.txt", "w", stdout);
#endif
```
### What will freopen do?

**freopen** is used to associate a file with stdin or stdout stream in C++.

### Why ONLINE_JUDGE?

**ONLINE_JUDGE** is a preprocessor directive on the online judge of most of the competetive coding sites, where it is defined to be true. So, when you submit the code containing above lines, these lines will simply get skipped due to ifndef condition!

You can find the same code for Python and Java [here](http://www.geeksforgeeks.org/inputoutput-external-file-cc-java-python-competitive-programming/).


## 5. Running the code

Now, we are left with the task of running our code.

Once you have written a C++ program and added the lines as stated in Step 4, you need to **build** your code. You can select any C++ build system for this purpose. 
 
Just write all the input that you want to pass as stdin in input.txt and build/run your code. And you will obtain the output as stdout in output.txt!

## Reference video

Here is a reference video which demonstrates the 5 steps as discussed above.

<iframe width="560" height="315" src="https://www.youtube.com/embed/DlPTG4AkuqU" frameborder="0" allowfullscreen></iframe>
