---
layout: post
title: "Ruby or NodeJS? The big question"
description: "What should we pick up today to learn ? "
headline: "The pertinent question of Ruby vs Nodejs"
modified: 2017-04-27 01:17:09 +0530
category: ['Development', 'Ruby', 'NodeJS']
tags: [ruby, rails, nodejs, js, javascript, trends]
feature-img: "img/post/ruby-or-nodejs/banner.png"
mathjax:
author: 'Vikas Burman'
chart: 
comments: true
featured: false
---
The small answer, “it depends”. It depends on what your context is, what
you are going to do with these platforms and associated frameworks.
Whether you are on the path of becoming a developer, or you already are
a developer and building a prototype, or you are part of a team which is
starting the next big project, or you a freelancer shaping your next big
idea.

Being general purpose development platforms both Ruby (w rails) and
NodeJS (w express) are good in their own respect. Depending upon your
very needs for the task at hand, you should pick the best tool for the
job. To make up your mind, here is a rundown on the **Trends**,
**Technology** and the **Techniques** for these two. For this
comparison, I am assuming you would be using [Ruby on
Rails](http://rubyonrails.org/) for Ruby, and
[ExpressJS](https://expressjs.com/) for NodeJS as the respective
frameworks of choice for the development.

**The Trends**

To begin with let’s look at some numbers on what others are doing in
this context. The [modulecount.com](http://www.modulecounts.com/) is a
good place to start. This site scraps module sites (such as npm,
rubygems, nuget, etc.) daily, to record available number of modules in
these. Changes over time is plotted on a graph. This graph gives us some
sense on what is the demand/supply scenario on modules for these
platforms. We can use this information to infer the popularity of the
platform as such. A quick comparison of modules’ count on
[rubygems.org](https://rubygems.org/) and
[npmjs.com](https://www.npmjs.com/) over multiple timelines gives us a
sense that NodeJS is really picking up since 2015 onwards and last year
has really been a NodeJS one from these data points.

<img src="/img/post/ruby-or-nodejs/node-ruby-modules.png" width="601" height="382" />

Fig. 1 Ruby vs NodeJS (all time)

Source: [modulecounts.com](http://www.modulecounts.com/)

<img src="/img/post/ruby-or-nodejs/image1.tiff" width="601" height="382" />

Fig. 2 Ruby vs NodeJS (May 2016 - Apr 2017)

Source: [modulecounts.com](http://www.modulecounts.com/)

Availability of modules over these community sites either means people
see value in NodeJS and want to make modules for it (highly plausible)
or creating modules for it is a lot easier than creating a Ruby GEM
(also highly plausible), but in no way, this reflects that a particular
framework or language is good or bad.

An interesting way to validate these graphs is to see google trends for
both these terms and see if there is a pattern match. On [Google
Trends](https://trends.google.com/trends/), comparing terms “Node.js”
and “Ruby” gives the view which somewhere confirms the popularity of
NodeJS over Ruby in recent years, but again this is not a reflection of
one being good or bad.

<img src="/img/post/ruby-or-nodejs/image2.tiff" width="601" height="151" />

<img src="/img/post/ruby-or-nodejs/image3.png" width="53" height="17" /><img src="/img/post/ruby-or-nodejs/image4.png" width="72" height="22" />

Fig. 3 Ruby vs NodeJS – Google Trends (2012 onwards)

Source: [Google Trends](https://trends.google.com/trends/)

TIOBE Programming Community index
([tiobe.com](https://www.tiobe.com/tiobe-index/)) is also an indicator
of the popularity of programing languages. This is based on the number
of skilled engineers world-wide, courses and third-party vendors, etc.
The April 2017 index shows JavaScript (the language of NodeJS) at
8<sup>th</sup> position while Ruby slipped (from 9<sup>th</sup>) to
11<sup>th</sup> position during this period.

**The Technology**

**Installation:** Both recommend using a version manager. Node’s version
manager (NVM) and Ruby’s version manager (RVM) are very similar.

**Project structure:** Both Express and Rails provide a generator to
generate an empty project to start with.

**Start:** Both provides a simple command to start server.

**Static content:** Both provides two ways to serve static files off the
server, either via a ‘public’ directory or via ‘views’ or ‘assets’, as
required.

**Data modelling:** JavaScript lets you do data modelling via JSON
objects and with a peculiar yet powerful class structure. Ruby on the
other hand tries to do magic in between by inheritance of classes when
it comes to data, and at times it becomes more than what is required,
especially when dealing with JSON data.

**Threading:** Ruby is multi-threaded in its operations which makes it
much better for CPU intensive operations, while NodeJS is single
threaded and was designed for heavy I/O bound applications.

**Callbacks:** Ruby is painfully sequential, no callbacks. NodeJS
functions asynchronously and offers enormous flexibility with constructs
like ‘promise’.

**Full stack:** From HTTP server to templating engine, NodeJS is the
whole package. Rails relies on something like Nginx or Apache with
Passenger to work.

**Uniformity:** With JavaScript, both on server and client code, NodeJS
offers same language benefit which increases productivity and gives an
extra value for money especially when it comes to hiring talent.

**The Techniques**

The language, Ruby is very powerful and expressive. It's easy to express
application logic in an intuitive way. Because of this very simplicity,
C++/Java developers are generally uncomfortable with it. The framework,
Ruby on Rails is opinionated. This makes you adhere to its way of doing
things out-of-the-box, from the routing system to ActiveRecord, Rails
assumes you build your apps in a particular way.

Ruby’s core principle is Convention over Configuration. This basically
means that even though there are many ways you can do a particular
thing, there is a certain way the community will deem as “correct”, and
if you do things the “correct” way your life will be easier. Therefore,
once you understand how one application works, you’ll notice other
applications, even written by other developers, organized in a
remarkably similar manner. However, if you want to do something on your
own, you'll spend a lot more time fighting with the framework and
figuring out how Rails wants you to do it, rather than actually doing
it.

The fact that Rails has so many layers of abstraction makes debugging a
pain. If a database call fails and the error message isn't informative,
you have to dig through Mongoid, ActiveRecord, ActiveSupport, Rack,
WEBrick... the list goes on. For the same reason, the canonical Ruby on
Rails app is heavier and therefore slower than the canonical NodeJS +
ExpressJS app.

NodeJS is blazing fast. Period. Because it is. Code in NodeJS is written
in JavaScript. Hence, for those with prior experience in front-end
development can easily learn NodeJS. It is easier to write code even for
those who are coming from C/C++ or Java background.

ExpressJS is un-opinionated. That means it doesn’t make your life easier
if you do things “the right way”. Node.js assumes nothing and gives you
the bare minimum from a fresh install. You'll have to write some code
and install some modules if you want to match the out-of-the-box
feature-set of Ruby on Rails like, interacting with a database,
implementing MVC or an advanced routing system. This gives you
flexibility but it takes little more time in initial development.

**Conclusion**

So, we can see that there is no definitive answer, however there are
reflections that can be used to prefer one over the other.

Both Rails and NodeJS can achieve the same results, Rails is perfect for
situations where you need to move quickly (prototyping, functional CRUD
app in the space of an hour) but a NodeJS skeleton app with some
pre-grouped Node modules can be just as fast as well.

In nut shell, NodeJS is best for fast single page app or highly
interactive apps, while Ruby on Rails is best for time to market of a
robust web app. Having said that, it is important to note that when it
comes to scalability you can't compete with NodeJS. There are companies,
that switched from Ruby on Rails to NodeJS including Netflix, New York
Times, PayPal, LinkedIn, Uber, etc. solely for performance and
scalability reasons.

----
_This guest post was written by Mr. Vikas Burman, VP of Technology, [Nagarro](http://nagarro.com)_

