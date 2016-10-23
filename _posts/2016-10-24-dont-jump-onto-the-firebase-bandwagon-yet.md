---
layout: post
title: "Don't jump onto the Firebase bandwagon yet"
description: 'Some caveats around using Firebase'
headline: ''
modified: ''
categories: [Android, Web]
tags: [Firebase, realtime, database, programming]
modified: 2016-10-24 02:21:39 +0530
feature-img:
mathjax:
chart:
comments: true
featured: false
---

**Firebase** is the rage. It's the talk of the town, and every frontend conference, be it _Web_ or _Mobile_ can't stop talking about [Firebase](http://firebase.google.com).

But hold your horses a bit out there. Now I am not saying that do not use Firebase. I use Firebase extensively. At [CodingBlocks](http://codingblocks.com) I make it a point to teach using Firebase to the students of the _Android_ programme. But all said and done, Firebase has a **specific** use case. And we cannot overlook that.

Firebase came about to be used as a _**realtime, object storage**_ system. Both the terms _realtime_ and _object_ storage are important. For one, being realtime is not something we always need. For a chat app yes, for a CRM, probably not needed at all. Secondly the data format of Firebase is very dubious.
It is an object store meaning, it resembles no-SQL databases like `MongoDB` and `DocumentStore` more than it does RDBMS like `MySQL` or `Oracle`. NoSQL is also something the cool kids have been harping on since 2010, but is again, useful for specific cases.

Now where my criticism of Firebase stems from are two easily overlooked points -   

1. The "object storage" uses a Database that is not transparent. We do not actually know if it used MongoDB on the backend or some other kind of database. And being proprietary, we do not actually know the availability/consistency tradeoffs, have any perf benchmarks etc of the underlying datastore that powers Firebase.
2. The issue with realtime is, it's too good to be true. And it is. Since more than 7 or 8 cases out of 10, you do not **actually** need something _really_ realtime (as in making a WebSocket connection and doing live 2-way updates), just getting realtime for the lulz is not a good idea. It will be resource intensive, expend more internet bandwidth on your client and devices, and _most important of all_ is a pricey business.

Let us expand on these points.

## The data storage problem

What the Firebase data model looks like is somewhat this (taking a blog) -

```
root
	- posts  
	    	- K1mn3b4m1n3
	        	- title: ""
	            - content: ""
	            - author
	    	- K2m3n4h2mn3
	        	- title: ""
	            - content: ""
	            - author
	    	- K3mn45b3mm3
	        	- title: ""
	            - content: ""
	            - author
	- comments  
	    	- K2m34nb2m
	        	- post : K1mn3b4m1n3
	            - title: ""
	            - content
	        - K62mn22m
	        	- post : K2m3n4h2mn3
	            - title: ""
	            - author: ""
```

There is a single node called **root** which is the entire DB of your app. Inside that there are _**refs**_ like `posts` and `comments` which are mostly analogous to _Collection_ of MongoDB.
Firstly, I just feel uneasy at the sight of the DB that looks like a single huge JSON file. I am extremely skeptical of how well it would scale when you put thousands of entries into each ref, and then create multiple relations between them like - post has auther=userid and comment has post = postid and author = userid and so on.

And as is the problem with [blindly starting to use noSQL](http://www.mongodb-is-web-scale.com/) (please do follow the link, you'll not regret it), you might be using it completely wrong, and/or in a place where traditional Relational SQL solutions would have fit better.


## The realtime problem

The second issue is when you are grabbed by your neck and force-herded into a realtime ecosystem, when you did not need it. Now a major portion of Firebase users actually did **not** need realtime databases. They just started using Firebase because Google made a big pomp and show of it at I/O 2016.

Thing is, pricing is very awkward. Upto 100 DB connections (simultaneous), you are on the free tier, named as `Spark`. (Trivia: I [suggested the name](https://twitter.com/championswimmer/status/594294732202774528) `Spark` to Firebase founder [James Tamplin](https://twitter.com/JamesTamplin), and the cool guy he is, he named the plan, earlier known as `Hacker` to `Spark`).
Beyond this, you do not have a $5 or $10 tier. You need to jump straight to the $25 plan.

Now take a step back and try to understand. 100 connections is **entirely** different from non-realtime datastores that provide usually _20 req/sec_ or _30 req/sec_ (what AWS, Parse, Azure mBaas limits are) on their free tier.
Firebase considers a user to be a _**connection**_ whenever he has his app open and connected to internet. (Side note: on mobile platforms like Android, you can do Firebase.goOnline() and Firebase.goOffline(), recently).

And trust me, if you're a chatting app, or a content reading app, getting to 100 simultaneous open connections is a **very easy to achieve target**.

The fact that Firebase is waaay too easy to plug in to your mobile apps (as much as single-line codes to make a ListView in Android connected to a Database Ref on Firebase, and having 2-way updates without any other code written), only makes me conclude that Firebase has got it's priorities straight up -  

- Hook in the devs using easy to use libraries
- Force them to be realtime
- Wait for them to get 100 online users
- Make $$$

---

And while all this makes good business sense for Google, it probably doesn't for you. So before you jump into the Firebase bandwagon like crazy, do your bit of math.

---


> Originally published on [blog.championswimmer.in](http://blog.championswimmer.in/2016/10/don-t-jump-onto-the-firebase-bandwagon-yet)
