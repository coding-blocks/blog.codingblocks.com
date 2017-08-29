---
layout: post
title: Getting the instance of a system service without an application context in Android
description:
headline:
modified: 2017-08-29 20:42:20 +0530
category: ['Android']
tags: []
feature-img:
mathjax:
chart:
author: 'Umair Khan'
comments: true
featured: false
---

I have been working on a project where I am supposed to execute some Java code, which uses Android APIs, outside the application environment. This means I don’t have access to any Android component i.e. Activity, Service, Broadcast Receiver etc. I was supposed to get the display’s width and height. Hence arose the need for hacking a way to achieve what is mentioned in the title, i.e. getting the instance of a system service without having an application context.

Normally, you need an instance of WindowManager service to get the device’s dimensions and the code would be something like this-

```java
WindowManager window = (WindowManager) getSystemService(Context.WINDOW_SERVICE);

Display display = window.getDefaultDisplay();

int width = display.getWidth();

int height = display.getHeight();
```

This works fine in normal situation. However, if you are not running your code inside an Android app, you don’t have an Android context. This means that you can’t call the method getSystemService() in the first place.

A large part of the Android OS is written in Java and that Java code also accesses the system services without having the application context. We’ll follow the same approach with our “app”.

There’s a way of doing inter-process communication in Android using AIDL. AIDL is short for Android Interface Definition Language. Basically, you define the same AIDL interface on the server side and the client side, and the client is able to call functions of a server service like a normal procedure call.

Specifically for getting a reference of WindowManager service, we do something like this. First of all, create an aidl folder next to the java folder in Android Studio. Create a package called android.view inside the newly created aidl directory. There, create a file named IWindowManager.aidl which should contain the methods you want to execute. For instance, if you want to get the device’s dimensions it could look like this –


```java
// IWindowManager.aidl

package android.view;

// Declare any non-default types here with import statements

interface IWindowManager {

    void getBaseDisplaySize(int displayId, out Point size);

}
```

Note: For any other system service, look for the corresponding aidl file for that service in the Android OS source tree.

After this, you need to get the IBinder object exposed by that service for IPC. For this, we need to call some hidden API methods via reflection.


```java
//get the reference of getService() method

Method getServiceMethod = Class.forName("android.os.ServiceManager").getDeclaredMethod("getService", new Class[]{String.class});

//get the IBinder object for the "window" service

IBinder binder = (IBinder) getServiceMethod.invoke(null, new Object[]{"window"})

//get the interface object to call the service functions

IWindowManager wm = IWindowManager.Stub.asInterface(binder);
```

After getting the IWindowManager instance, we can easily call its methods like a normal procedure call.

```java
wm.getBaseDisplaySize(0, displaySize);
```

Lastly, the API exposed by the service using the AIDL interface is not exactly the same as the one exposed by the actual system service when you go the normal way. However, you can easily find the corresponding methods for doing one thing or the other, or may be even extra.
