---
layout: post
title: "Docker Spring Cleaning"
description: "Over the course of development, Docker cache tends to take over a huge chunk of your hard drive. While not always an issue, sometimes it may lead to Docker builds failing because you're out of disk. Prajjwal Singh explains how to quickly get rid of it."
headline: Docker Spring Cleaning
modified: 2017-06-06 20:33:22 +0530
category: Engineering
tags: [docker]
feature-img:
author: 'Prajjwal Singh'
comments: true
featured: false
---

Or how I learned to stop worrying and reclaim my disk space.

About two months ago, the engineering team set out to Dockerize one of our
services, it being the container technology to finally vanquish the evil that is
virtualization, and bring about peace on Earth. While we grossly underestimated
the effort that would go into it, and much like Tolkien's hobbit regretted ever
having ever left the Shire. It paid off in the end, though, but that's another
blog post. Deploying our problem judging backend across multiple machines
running different operating systems is now a breeze. This post details one of
the major snags we ran into while developing a `Docker` image from scratch -
accumulation of garbage on disk, and also how to quickly get rid of it all.

Over the course of development, you will end up with a plethora of dangling
images, and unused volumes on your hard drive. Sometimes, this also leads to
your builds complaining about a lack of space on the device. Here's what you
need to do to spring clean.

## Remove Images

Grab all images (including stopped ones with):

```
docker ps -a
```

After a while, this is an annoyingly long list. Remove a single image with:

```
docker rmi CONTAINER_ID
```

Force removal with:

```
docker rmi --force CONTAINER_ID
```

However, with some command line fu, you can remove everything in one go:

```
docker ps -a | tail +2 | awk '{print $1}' | xargs -I{} docker rmi --force {}
```

Copy pasters can stop reading at this point, but here's an explanation:

`docker ps -a | tail +2` spits out all but the leading line in the output, which
gets rid of the table headings. Piping that to `awk` gives us only the first
column, which is now a newline separated list of `CONTAINER_IDs`. Finally, we
use `xargs` to execute the command `docker rmi --force` to force removal of each
of the images.

## Docker Prune

You also have a more powerful command at your disposal - `docker system prune`.
It will remove unused `Docker` data from your system.

If you really want to nuke **everything**, do this.

```
docker system prune --all
```

Here's the self explanatory warning it spits out:

```
WARNING! This will remove:
	- all stopped containers
	- all volumes not used by at least one container
	- all networks not used by at least one container
	- all images without at least one container associated to them
```

I've cleaned up > 20 gigs of junk on my hard drive on two separate occasions
with these.

Now go burn that cache to the ground. Follow
[@prajjwalsin](https://prajjwal.com/@) while you're at
it.
