---
layout: post
title: "Local variable pointer returning changes in GCC 5"
description: "Changes in GCC 5 to how local variable pointers are returned from a function"
headline: "Local variable pointer returning changes in GCC 5"
modified: 2016-11-28 15:59:38 +0530
category: ["C++", "Programming Tips"]
tags: [cpp, c, gcc, programming]
feature-img: 
mathjax: 
chart: 
author: "Arnav Gupta"
comments: true
featured: false
---

Returning local variable points from a function is something you should
**never** do. Because the returned address will exist, but the 
data inside it will have lost it's scope.

Nevertheless, whether or not you _should_ do it, is something people often
disregard, and thus GCC 5.x and above have tried to ensure you don't.

Starting from `5.0.0` and above versions of GCC (and in extension G++), you
**cannot** return local variable pointers from a function

Thus a program like this - 

```cpp
#include <iostream>

using namespace std;


int * createArr () {
    int arr[3] = {1,2,3};

    cout << "function " << arr << endl;

    return arr;
}


int main() {
    int * val = createArr();
    cout << " main " << val;
}
```  

Will return this in GCC5   
```shell
function 0x7fff5e9e18f0   
main 0
```

In earlier versions of GCC (4.9 and below) it used to return this -  
```shell
function 0x7fff5e9e18f0   
main  0x7fff5e9e18f0
```

TD;DR;
In GCC5.x and above, local variable pointers in a function are returned as `0` to the calling function
