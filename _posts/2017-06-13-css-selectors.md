---
layout: post
title: "CSS Selectors"
description: "Introducing CSS Selectors"
headline: "How to use CSS selectors properly"
modified: 2017-06-13 18:17:30 +0530
category: personal
tags: ['css','selectors','html']
feature-img: 
author: 'Aayush Arora'
comments: true
featured: false
---

Analogically we can understand the designing of a web page as a construction of a room where `HTML` can be compared with `bricks` used to provide the structure of that room.

`CSS` adds styling to the web page that can be compared with `painting`, adding curtains and decorating the room. 

`Javascript` adds behavior to a web page, functionalities such as lights inside the room.

All HTML, CSS, and JS together help us to design a web application. 

Proper Styling of our room will definitely bring more customers to us, and the same works when we style our web pages better that attract more number of users.

Apart from some basic selectors like `class` and `id`, there are some CSS selectors that can help us to write effective `CSS` code. Let's compare them with their use cases. 

### 1. `element element` & `element > element`'


#### 1.1 _*element element*_

This styling will work on all child **element** that are nested under the parent **element** without considering the `level of nesting`.
##### Example:

  ```
 <!-- HTML-->  
 <div>
        <span>
            <p> Inside span 1 </p>
        </span>
        <span>
            <p> Inside span 2 </p>
        </span>
        <span>
            <p> Inside span 3 </p>
        </span>
        <span>
            <p> Inside span 4 </p>
        </span>
        <p> Inside div and outside span </p>
</div>
```
```
    /* Use this selector when you have to select all
       p elements inside a div regardless of their nesting level */
    div p {
        color: #ff7f50;
    }
```
#### Output: 
 ![Image](https://user-images.githubusercontent.com/12194719/27030806-45146e92-4f8b-11e7-8570-16a424344cc6.png)

----
#### 1.2  _*element > element*_
This styling will work for nested elements after writing the nested levels. The nested level can be reached by using `>`.
To apply the `styling` to the `<p>` tag using `>` can be applied as:
```
div > span > p {
  color: #ff7f50;
}
```
But what will happen if we use `div > p`. This will strictly select only those `<p>` elements which are in `div` but will leave those which are nested one level down in `<span>`.

#### Output:

![div > p](https://user-images.githubusercontent.com/12194719/27073848-dfe9d530-5042-11e7-905b-ef301ac1bbd0.png)

----
### 2. `element + element` & `element ~ element`
#### 2.1 _*element + element*_
This styling will be applied to the first element that comes immediately after the other `element`. Here, `p` is the `first element` that comes immediately after `div`. We can also say that `<p>` is the `immediate sibling` of `<div>`.

#### Example:
```
<style>
    
    div + p {
        color: green;
    }

</style>
```
```
<body>
    <div>
        <span>
            <p> Inside span 1 </p>
        </span>
        <span>
            <p> Inside span 2 </p>
        </span>
        <span>
            <p> Inside span 3 </p>
        </span>
        <span>
            <p> Inside span 4 </p>
        </span>
        <p> Inside div and outside span </p>
    </div>
    <p> Outside div and Immediately after </p>
    <p> Outside div and Not Immediately after</p>
</body>
```
#### Output: 
![](https://user-images.githubusercontent.com/12194719/27080403-520b8d8c-5059-11e7-8888-cf44780290b6.png)

----
#### 2.1 _*element ~ element*_
To understand this, we changed our `HTML`. This style works on all elements which are the sibling of the other element. There is no need to be the `immediate sibling` in this case. 

##### Example:
```
<!-- HTML -->
<body>
    <div>
        <span>
            <p> Inside span 1 </p>
        </span>
        <span>
            <p> Inside span 2 </p>
        </span>
        <span>
            <p> Inside span 3 </p>
        </span>
        <span>
            <p> Inside span 4 </p>
        </span>
        <p> Inside div and outside span </p>
    </div>
    <p> Outside div and Immediately after </p>
    <p> Outside div and Not Immediately after</p>
    <span>
            <p> Nested inside span</p>
    </span>
    <p> Not an immediate sibling </p>
</body>

```
```
 div ~ p {
        color: green;
    }

```
#### Output: 
![Output4](https://user-images.githubusercontent.com/12194719/27080942-cc05a300-505b-11e7-9d88-4c2d2a8db47c.png)

The styling will not be applied to `<p>` which is outside `<div>` but nested inside `<span>` as it is not a sibling of `<div>` element.

If we know how to write CSS effectively, then it is very easy to write less code which will make the web pages faster. CSS is `easy` to learn but `hard` to master.