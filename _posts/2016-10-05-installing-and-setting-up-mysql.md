---
layout: post
title: "Installing and Setting up MySQL"
description:
headline:
modified: 2016-10-05 16:50:42 +0530
category: tutorial
tags: []
feature-img:
mathjax:
chart:
comments: true
featured: false
author: 'Arnav Gupta'
---

# Installing and setting up MySQL

This page contains the common code snippets used to installing and setup MySQL server initially on your personal machine.

## Mac
If you have homebrew
```
brew install mysql
mysql.server restart
```

## Linux

```
sudo apt-get install mysql-server
```

## Windows

Figure out yourselves :P


## Setting up database and user

### Creating new database

```mysql
create database newdatabase;
```

### Creating new user

```mysql
create user 'newuser'@'%' identified by 'newpassword';
```


Now exit and login with new user

```bash
mysql -u newuser -p
```
