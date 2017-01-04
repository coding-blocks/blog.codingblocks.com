---
layout: post
title: "Setting up HTTPS with free SSL certificate on Ubuntu/Nginx"
description: "Using Letsencrypt to generate SSL certificate"
headline: "Setting up HTTPS with free SSL certificate on Ubuntu/Nginx"
modified: 2017-01-04 17:27:49 +0530
category: ["Web", "Server Administration"]
tags: [web, https, security]
feature-img: 
mathjax:
author: "Arnav Gupta"
chart: 
comments: true
featured: false
---

## What I wanted to do


To begin with, let me lay down what this article is about and what it is not.

Here is a web server setup that I want to use with HTTPS -


| OS           | Ubuntu 16.04.1                     |
| Proxy Server | Nginx  |
| Web App      | NodeJS (Express)                   |

I have [this url shortener](http://github.com/coding-blocks/shorturl) running on port 4000,
and hence my nginx config looks like this -

```
server {
    listen 80;
    server_name cb.lk;

    location / {
        proxy_pass http://127.0.0.1:4000/;
    }
}
```

What my requirements were  -

 - Generate an SSL certificate for the domain cb.lk
 - Make the SSL work with my site, if viewed over https

I am concerned with the most basic functionality, of just having an SSL certificate
and a working HTTPS connection.
I am not concerned with adding enhanced security features much, and the setup I
am going to describe below, still has many holes to plug. (But anyway there are
way too many security holes, other than my transport layer, so I do not really care).


## Generating an SSL certificate for free

[Letsencrypt](https://letsencrypt.org/) (Stylised as **Let's Encrypt**) is a non-profit
Certification Authority. They are doing good work for the community, and you should
[donate to them](https://www.generosity.com/community-fundraising/make-a-more-secure-web-with-let-s-encrypt) ,
to help them continue, if you can.



To generate a `letsencrypt` certificate, you can simple install it using apt-get in Ubuntu
(It's already there in xenial packages).

```shell
sudo apt install letsencrypt
```

After that we will generate a few files that letsencrypt checks to see if you really own the server or not.
Now, you need to perform this step from a folder **that is (or can emulate) the webroot** of your website.
In my case, it is a NodeJS app, so I do not have a _docroot_ per se. So here's what I do; I will run this command
(_NOTE: Do not actually run it right now_)

```shell
letsencrypt certonly --webroot -w . -d cb.lk -d www.cb.lk
```

 - -w : signifies your webroot (using the root of my project)
 - -d : signifies domain, and I add both cb.lk and www.cb.lk

After this, you'll see a folder `.well-known` getting generated where you ran the command.

**BUT WAIT**, before I run this command, I need to make sure this folder that will get generated,
will be available over my server. So, what I do is this -

In my NodeJS app's express configuration I have to add this line, so the
`.well-known` folder gets statically served.

```javascript
app.use('/.well-known', express.static(__dirname + "/.well-known"));
```

Then I restart my nodejs webapp, and then I actually run the command I showed earlier -

```shell
letsencrypt certonly --webroot -w . -d cb.lk -d www.cb.lk

```


## Configure
Now my certificate is generated, but the following tasks are left.

 - Use cb.lk over port 443, with ssl
 - Add the path of the ssl certificate in nginx config

So first, I create a new file `/etc/nginx/snippets/ssl-cb.lk.conf`
The contents of that file are -

```
ssl_certificate /etc/letsencrypt/live/cb.lk/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/cb.lk/privkey.pem;
```
(Replace cb.lk with your site's domain record ofcourse)

And then edit the nginx config `/etc/nginx/sites-available/cblk.conf` to this

```
server {
    listen 80;
    listen 443 ssl http2;
    server_name cb.lk;

    include snippets/ssl-cb.lk.conf;

    location / {
        proxy_pass http://127.0.0.1:4000/;
    }
}
```

Check syntax of nginx configs with `sudo nginx -t`
If all good, restart nginx

```shell
sudo service nginx restart
```

And there you go. Both <http://cb.lk/admin> and <https://cb.lk/admin> are active
