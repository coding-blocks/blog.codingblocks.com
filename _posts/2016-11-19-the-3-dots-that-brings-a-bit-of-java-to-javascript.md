---
layout: post
title: "The 3 dots that brings a bit of Java to Javascript"
description: "Rest and Spread in ECMAScript6"
headline: "The 3 dots that brings a bit of Java to Javascript"
modified: 2016-11-19 19:57:14 +0530
category: [Javascript, "Development tips", Web]
tags: [javascript, es6, varargs, java, ecmascript]
feature-img: 
mathjax: 
chart: 
comments: true
featured: false
---

Everyone who has used Java or other languages that support _varargs_ (or 'variable number of arguments')
would know what a big boon that is. 

Consider you have a function that creates file path strings. (This is basically what `path.join()` in Javascript does)
```javascript
function pathJoin(folder1, folder2, folder3) {
    return "/" + folder1 + "/" + folder2 + "/" + folder3 + "/";
}

var p = pathJoin("my", "favourite", "folder")
```
Here _p_ will be "/my/favourite/folder/"

But we want to create the function in such a way that it works for any number of arguments
and not just for 3 arguments.

Java supports, what it calls as **varargs**. Which allows us to send
and optional number of arguments in form of an array. 


```java
public static int sumAll(Integer... numbers) {
    int sum = 0;
    if (numbers.length > 0 ) {
        for (Integer n : numbers) {
            sum += n;
        }
    }
    return sum;
}

int sumOdd = sumAll(1,3,5,7,9);
int sumEven = sumAll(2,4,6,8);
int sumZero = sumAll();
```

So basically we are sending in 3 or 4 (or even 0) seperate variables to the function `sumAll`
but the function treats them as an array `numbers`  
This is exactly what the _varargs_ operator (that elipsis, or 3 dots) does.  

So `int... n` means a variable number of integers, represented as an array `int[] n`

Now, with ECMAScript2015 (ES6) having been standardized, we have the
[spread](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Spread_operator)
and [rest](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters)
operators in Javascript, that does something similar, and even better
it has support of varargs both in function definition, **as well as** function calls.

### Spread Syntax
Take a look at how the spread syntax can **spread** an array

```javascript
var parts = ['shoulders', 'knees'];
var lyrics = ['head', ...parts, 'and', 'toes']; // ["head", "shoulders", "knees", "and", "toes"]
```

And check how it can help inject arrays into functions 

```javascript
function myFunction(x, y, z) { }
var args = [0, 1, 2];
myFunction(...args);
```


### Rest Parameters
Take a look at how the rest parameters syntax works. This uses the spread operator we saw above

```javascript
function fun1(...theArgs) {
  console.log(theArgs.length);
}

fun1();  // 0
fun1(5); // 1
fun1(5, 6, 7); // 3
```

_NOTE: Javascript, prior to ES6, also had the global 'argument' in each function object, but that was not a real array. Rest parameters have `sort`, `map`, `pop` etc calls, because they are real Arrays_

<i><b> <span style="color: red"> IMPORTANT NOTE: The spread operator does only 1-level copy of array, and not a deep copy, so do not use for multi-dimensional arrays</span> </b></i>