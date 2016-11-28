---
layout: post
title: "Android Protip: Show selected value of ListPreference"
description: 
headline: 
modified: 2016-10-18 08:04:52 +0530
category: [Android, "Development Tips"]
tags: [android, preferences]
feature-img: 
mathjax: 
chart: 
author: 'Arnav Gupta'
comments: true
featured: false
---

Here's a quick Protip for people who are still writing complex `onPreferenceChanged` code to show the selected value of a *ListPreference*

Just add `android:summary="%s"` and Android will automatically do it for you ;) 

For example, your code might look like : - 

```xml
    <ListPreference
        android:summary="%s"
        android:defaultValue="km"
        android:entries="@array/distance_unit_names"
        android:entryValues="@array/distance_unit_values"
        android:key="distance_unit"
        android:title="Distance Unit"/>

```  

Android will even put the currently selected value when you enter the preference screen.   
