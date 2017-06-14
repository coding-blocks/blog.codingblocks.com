---
layout: post
title: How To Manage and Use Dependencies in your Ember Addon
description: Managing dependencies can be quite confusing, especially in your first Ember Addon. This aims to be a clear tutorial on how to do handle it gracefully.
modified: 2017-06-14 12:13:12 +0530
category: [Tutorial]
tags: [EmberJS, JavaScript]
author: Abhishek Gupta
comments: true
featured: false
---

Many developers when writing their first ember addon confuse it with an ember app. Yes, both ember addon and ember app follows similar code structure and conventions. However, both are fundamentally different when it comes to managing dependencies and using them. Before we move on, first let’s get some things out of the way.

## Npm or Bower?

Bower. Given the current scenario in Ember land, you should be using bower to install manage you external-frontend dependencies. Later, we’ll see how convenient bower is for our purpose and hooks ember provides to manage packages installed via bower. However, it’s all possible for npm modules as well.

When you create a new ember addon , you’ll notice a bower.json file inside root directory. One might think that adding our dependencies to this bower.json will do the trick. I did too. However it is not so, as again ember addons and NOT ember apps. That bower.json installs the dependencies for this time, but doesn’t tell our host application(which will install this addon) about the dependencies.

## So how does ember install work anyways?

*When you do `ember install <addon>`, all `ember-cli` does is add `<addon>` to `package.json` and run `npm install && bower install` and then run the `blueprint(s)` specified in the addon.

The key thing to note here is `blueprint`. A blueprint runs additional code after the addon is installed. It has to be named the same as the addon. This makes blueprint perfect place to add our dependencies.

### Define dependencies

So now to the interesting part, we now actually define our dependencies. First we create the `blueprint` file for our addon. In your root directory create `blueprints/<addon-name>/index.js` like so:

```javascript
module.exports = {
  normalizeEntityName: function() {}, // no-op since we're just adding dependencies

  afterInstall: function() {
    return this.addBowerPackagesToProject([
        { name : 'moment' , target : '^2.10.0'},
        { name : 'material-datetime-picker'},
        { name : 'rome'}
    ]);
  }   
}
```

Ember provides various hooks to load npm and bower packages. They are as follows:

- `addAddon(s)ToProject`: Adds an addon to the project’s package.json and runs its defaultBlueprint if it provides one.
- `addBowerPackage(s)ToProject`: Adds a package to the project’s bower.json.
- `addPackage(s)ToProject`: Adds a package to the project’s package.json.

And all of these return Promises so all its all then-able so you can load dependencies one after another and any order you prefer. Also it all goes into the `afterInstall` hook, which is called after `ember-cli` is finished installing other dependencies.

Now, we’ve done it. All our dependencies will be correctly installed within our host application alongside our addon.

But, not so fast! , Your addon cannot yet use these dependencies as they are not imported yet. I think now you know why just an `app.import` in `ember-cli-build.js` will not work. So let’s see the solution

### Index.js to the rescue

`index.js` as the name suggests, is the first file that is picked up when your addon boots up (after all the installation spaghetti). So well use this opportunity to import our dependencies as well!. Modify your index.js , located in the root directory of your addon like so

```javascript
module.exports = {
  name: 'ember-datetime-picker',
  included(app) {
    
    // include this addon for `dummy` application for testing
    this._super.included(app);
    
    // import he library into global namespace
    app.import(app.bowerDirectory + '/moment/moment.js');
    app.import(app.bowerDirectory + '/rome/dist/rome.min.js');
    app.import(app.bowerDirectory + '/material-datetime-picker/dist/material-datetime-picker.js');
    app.import(app.bowerDirectory + '/material-datetime-picker/dist/material-datetime-picker.css');
    //app.import(app.bowerDirectory + '<path to dependency>.js');
  },
  contentFor(type,config){
    // type can anything like 'head' 'body' etc.. look for {{content-for '<typename>' }} in index.html
    if(type=='head')
    {
      // bonus!, you can add CDN requests here to load files from CDN, 
      // all the this is include in the <head> section of the page
      // where your addon is used 
      const headFile = `<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
                        `;
      return headFile;
    }
  }
};
```

The code above is pretty much self explanatory. Now before you jump at me for pulling all libraries into global scope — YES, it is not the best practice to do so. The workaround is to create a `shim` for the library (if one not exists already). I’ll leave that topic for later. Basically a `shim` is some boilerplate code which allows AMD or CommonJS modules to be imported like ES6 modules. So you’ll be able to do this:

```javascript
import moment from 'moment' ;
```

So, finally you are all set for writing your **dependable** ember addon. Good Luck.

## Further Reading
- [External Dependencies & Ember Addons](http://manukapoor.net/blog/external-dependencies-and-ember-addons/)
- [Ember CLI: Extending](https://ember-cli.com/extending/)
