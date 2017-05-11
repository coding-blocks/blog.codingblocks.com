---
layout: post
title: "Checking out pull request from Github"
description: "How to checkout a PULL REQUEST from Github without merging"
headline: "So your repository got a PR from a enthusiastic developer."
modified: 2017-05-02 14:52:54 +0530
category: Git
tags: [github, git, pull, checkout]
feature-img: img/post/github-pr/pr.png
mathjax: 
chart:
author: Arnav Gupta
comments: true
featured: false
---
So your repository got a PR from a enthusiastic developer. You don’t want to
merge it before testing it out yourself locally on your dev machine. How do you
go about it ?

<center>
<img src="https://cdn-images-1.medium.com/max/1600/1*ubVyD2GaOAlSfqRNbL0Bjg.png">
<br>
<small align="center" class="figcaption_hack">How pull requests work on Github (from — gitcolony.com)</small>
</center>


The pull request is available on this git ref `pull/{*ID}*/head` which you can
fetch using this, where ID is the pull request id.
```
    git fetch origin pull/
    /head && git checkout FETCH_HEAD
```


Or, if you only want to cherry pick it, instead of checking it out, you can use

```
    git fetch origin pull/
    /head && git cherry-pick FETCH_HEAD
```

<br>

* [Github](https://medium.com/tag/github?source=post)
* [Git](https://medium.com/tag/git?source=post)
* [Pull Request](https://medium.com/tag/pull-request?source=post)

