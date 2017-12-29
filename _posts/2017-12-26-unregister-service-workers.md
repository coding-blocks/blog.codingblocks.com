---
layout: post
title: "How to Unregister Service Workers?"
description:
headline:
modified: 2017-12-26 08:20:47 +0530
category: ['Javascript']
tags: [javascript, serviceworkers , cache]
feature-img: ""
mathjax:
chart:
author: 'Himank Bhalla'
comments: true
featured: false
---

The service worker API comes with a Cache interface that lets you create stores of responses keyed by requests. The programmer is responsible for implementing the service worker script to handle the updates to cache. The items in the cache must be explicitly updated.

Recently I faced this issue with service workers. The cached items were not updated. As a result, I couldn’t get the latest committed work on my browser. The project was in beta phase, changing frequently. A lot of client requests came for the same. So I wrote this blog to help them and others who want to unregister service workers.

**For google chrome users:** 
- Go to Developer Tools (**ctrl shift i**/**cmd opt i**) or right-click on any page element, then click **Inspect**.
- Go to the **Application** tab and then click on service workers in the left bar. It will list all the registered service  workers.
- Click on **unregister** to disable that particular service worker.



{% include image.html
    img="/img/post/unregister-service-workers/google-chrome-serviceworker.png"
    title="Google Chrome Developer Tools"
    caption="Google Chrome Developer Tools"
 %}

**For mozilla firefox users:**

- Click on **tools** => **web developer** => **service workers**.
- It will list all the registered service workers. Click on unregister to disable that particular service worker.

{% include image.html
    img="/img/post/unregister-service-workers/mozilla-steps.png"
    title="Mozilla Developer Tools"
    caption="Mozilla Developer Tools"
 %}

 {% include image.html
     img="/img/post/unregister-service-workers/mozilla-service-worker.png"
     title="Service worker mozilla"
     caption="Service worker mozilla"
  %}
