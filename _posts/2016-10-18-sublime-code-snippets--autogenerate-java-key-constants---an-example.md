---
layout: post
title: "Sublime Code Snippets : Autogenerate Java key constants - an example"
description: 
headline: 
modified: 2016-10-18 08:08:20 +0530
category: ['Development Tips']
tags: []
feature-img: 
mathjax: 
chart: 
author: 'Arnav Gupta'
comments: true
featured: false
---
I largely use [Jetbrains](http://jetbrains.com) products for my day to day development work (which is mostly Android). I really love the _Live Template_ feature that is available on IntelliJ, for example if I type `psfs` and press `Tab` I get the following on the screen 
```java
public static final String
```

These days, sometimes I use Sublime Text 3 as well, because unless I need all the features of an IDE, it's too heavy to open up, especially if other stuff is running on the laptop. One of those days when I was using Sublime, I needed to create a lot of Database key constants - i.e. in the form of 
```java
public static final String KEY_ONE = "key_one"
```

So it so happens that there exists functionality like live templates on Sublime as well, in form of **Snippets**

To create a new Snippet, go to Tools -> New Snippet. 
Ideally you save your snippets in `~/.config/sublime-text-3/Packages/User/MySnippet.sublime-snippet`

Here is an example config for the Snippet that creates Java key constants

```xml
<snippet>
	<content>public static final String ${1/(.+)/(\U\1)/g} = "${1}";</content>
	<tabTrigger>jkey</tabTrigger>
	<scope>source.java</scope>
	<description>public static final String KEY = "key"</description>
</snippet>
```

Now when you type `jkey` and press tab, it creates 
```java
public static final String | = "|"
```

The pipes `|` represent the cursor position. When you start typing in lowercase for example `my_key_one`, automatically the variable name updates in uppercase `MY_KEY_ONE`. 