---
layout: post
title: "Working with Google APIs | Part 1"
description: "Exploring Google APIs using Python"
headline: "Getting started with Google APIs"
modified: 2017-03-19 10:52:08 +0530
category: [web]
tags: [google, api, web, python, youtube]
feature-img: "img/post/google-apis/google_developers_logo.gif"
author: Nikhil Kumar Singh
mathjax: 
chart: 
comments: true
featured: false
---


Google is more than a search engine, and we all know that!

Google provides a wide range of web products and services. And Google APIs are an important part of them!

Google provides a plethora of APIs which can be easily integrated with your web or desktop applications.

Several popular APIs provided by Google are:


- [Google YouTube API](https://developers.google.com/youtube/v3/)
- [Google Maps API](https://developers.google.com/places/)
- [Google Custom Search API](https://developers.google.com/custom-search/)
- [Gmail API](https://developers.google.com/gmail/api/)
- [Google Machine Learning APIs](https://cloud.google.com/products/machine-learning/)

...and many more!

In this tutorial series "Working with Google APIs", we are going to explore several popular APIs provided by Google using Python programming language.

This is the first part of this tutorial series. In this part we are going to learn how to:


- Create a new project on Google Cloud Platform.
- Create credentials to use Google APIs.
- Exploit YouTube Data API to extract data from YouTube.

## 1. Creating a new project

**Google API Console** lets you discover and use Google APIs.

Before you can use any Google API, you must have a **Google API Console project**. A project allows you to manage all the APIs provided by Google.

### Steps:


- Go to the [Google API Console](https://console.developers.google.com/project/_/apiui/apis/library).
- From the project drop-down, select an existing project , or create a new one by selecting **Create a new project**.

## 2. Enable API and create credentials

In order to integrate an API with your project, you need to **enable** it.

### Steps to enable API:


- Go to [Google API Console](https://console.cloud.google.com/apis) and select a project from project drop-down.
- In the sidebar under "API Manager", select "Library". Now, you can see a list of popular APIs. You can also type the name of any API in search bar too.
- Select the API you want to enable. In this article, we are going to explore **YouTube Data API**. So, in the YouTube APIs section, 
  you can select the YouTube Data API.
- Click on **enable** button.

Now, in order to access enabled API by HTTP requests, you need to set up some credentials.

Google supports two mechanisms for creating credentials or unique identifiers:


- **OAuth 2.0 client IDs:** For applications that use the OAuth 2.0 protocol to call Google APIs, you can use an OAuth 2.0 client ID to generate 
  an access token. The token contains a unique identifier.
- **API keys:** An API key is a unique identifier that you generate using the console. Using an API key does not require user action or consent. 
  API keys do not grant access to any account information, and are not used for authorization.

If you're calling only APIs that do not require user data, such as the Google Custom Search API, Google Maps API, etc. then API keys might be simpler to use than OAuth 2.0 access tokens. However, if your application already uses an OAuth 2.0 access token, then there is no need to generate an API key as well. Google ignores passed API keys if a passed OAuth 2.0 access token is already associated with the corresponding project.

In this part, we are going to use **API keys** only for creating credentials for **YouTube Data API**.

### Steps to create an API key:


- In the sidebar under "API Manager", select **Credentials**.
- In the Credentials tab, select the **Create credentials** drop-down list, and choose **API key**.
- Currently, we will use API key to access data through python scripts, we will use an "restriction-less" key. You can impose some restrictions on your 
  API-key by select the "Edit settings" option of the key.

## 3. Python scripts to interact with YouTube Data API

Once you have enabled a Google API, you can interact with it via HTTP requests.

In this part, we are going to play with [**YouTube Data API**](https://developers.google.com/youtube/v3/).

### Installations:


* Python (any version)
* Google API python client.
  You can install it using a simple pip command:
  ```
  pip install --upgrade google-api-python-client
  ```
  
### Example 1

In the first example, we are going to create a **youtube_search** function which will return us the data about **videos**, **channels** and **playlists** related to a search query.

Consider the code below:


```python
from apiclient.discovery import build

# arguments to be passed to build function
DEVELOPER_KEY = "Your API Key here"
YOUTUBE_API_SERVICE_NAME = "youtube"
YOUTUBE_API_VERSION = "v3"

# creating youtube resource object for interacting with API
youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION,
                    developerKey=DEVELOPER_KEY)


def youtube_search(query, max_results = 5):
    
    # calling the search.list method to retrieve youtube search results
    search_response = youtube.search().list(q = query,
                                            part = "id,snippet",
                                            maxResults = max_results).execute()
    
    # extracting the results from search response
    results = search_response.get("items", [])

    # empty list to store video, channel, playlist metadata
    videos = []
    playlists = []
    channels = []
    
    # extracting required info from each result object
    for result in results:
        # video result object
        if result['id']['kind'] == "youtube#video":
            video = {}
            video['id'] = result["id"]["videoId"]
            video['title'] = result['snippet']['title']
            video['descr'] = result['snippet']['description']
            video['thumbnail'] = result['snippet']['thumbnails']['default']['url']
            videos.append(video)
        # playlist result object
        elif result['id']['kind'] == "youtube#playlist":
            playlist = {}
            playlist['id'] = result['id']['playlistId']
            playlist['title'] = result['snippet']['title']
            playlist['descr'] = result['snippet']['description']
            playlist['thumbnail'] = result['snippet']['thumbnails']['default']['url']
            playlists.append(playlist)
        # channel result object
        elif result['id']['kind'] == "youtube#channel":
            channel = {}
            channel['id'] = result['id']['channelId']
            channel['title'] = result['snippet']['title']
            channel['descr'] = result['snippet']['description']
            channel['thumbnail'] = result['snippet']['thumbnails']['default']['url']
            channels.append(channel)
        
    return videos, playlists, channels



if __name__ == "__main__":
    result = youtube_search('Coding Blocks', max_results = 10)
    print("Videos:", result[0])
    print("Playlists:", result[1])
    print("Channels:", result[2])
```

When you run above code, you will get separate lists of videos, channels and playlist results.

A sample video element looks like this:
```
{'descr': 'Watch Arnav Gupta teaching Hacking through the Android OS Code at '
          "DroidCon 2014, India's Biggest Android Development Conference.",
 'id': 'kPwGMMVY93k',
 'thumbnail': 'https://i.ytimg.com/vi/kPwGMMVY93k/default.jpg',
 'title': 'Hacking through the Android OS code - Arnav Gupta | Coding Blocks'}
 ```
 A sample playlist element looks like this:
 ```
 {'descr': '',
 'id': 'PL8A7E8B635FF6804B',
 'thumbnail': 'https://i.ytimg.com/vi/tvC1WCdV1XU/default.jpg',
 'title': 'Buckys C++ Programming Tutorials- CodeBlocks'}
 ```
 A sample channel element looks like this:
 ```
 {'descr': 'The Coding Blocks YouTube channel is all about bringing you '
          "tutorials, tips, how to's and best practices on working your way to "
          'being the best programmer or ...',
 'id': 'UCcxbkpkf7_zhf3YceK8JMQw',
 'thumbnail': 'https://yt3.ggpht.com/-dGIgUBoa4sM/AAAAAAAAAAI/AAAAAAAAAAA/kZ1fSAxQbVA/s88-c-k-no-mo-rj-c0xffffff/photo.jpg',
 'title': 'Coding Blocks'}
 ```

The code is pretty much self-explanatory. 
However, some important things to ponder upon are:


- **apiclient** is a python client to interact with the Google APIs in an easier way.
- In order to use an API, you have to build a **resource object** for that API. 
  In above example, we did that using these lines of code:
  ```
  youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION,
                    developerKey=DEVELOPER_KEY)
  ```
  We passed the service name, its version and our Developer(or API) key to **build** method of **apiclient.discovery** module.
  Note that the **part** parameter specifies a comma-separated list of one or more video/playlist/channel resource properties 
  that the API response will include.
- Now, we use **search.list** method of resource object to fetch search results. 
  You can read more about it [here](https://developers.google.com/youtube/v3/docs/search/list).
- Once search results are available, we fetch required info from the JSON structured object. 

## Example 2

In this example, we will try to extract some more content and statistical info from a video.

Consider the code below:


```python
from apiclient.discovery import build

# arguments to be passed to build function
DEVELOPER_KEY = "Your API key here"
YOUTUBE_API_SERVICE_NAME = "youtube"
YOUTUBE_API_VERSION = "v3"

# creating youtube resource object for interacting with API
youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION,
                    developerKey=DEVELOPER_KEY)


def video_details(video_id):

    # Call the videos.list method to retrieve video info
    result = youtube.videos().list(
        id = video_id,
        part = "id,snippet,contentDetails,statistics",
    ).execute()
    
    # Extracting required info about video
    video = {}
    video['title'] = result['items'][0]['snippet']['title']
    video['tags'] = result['items'][0]['snippet']['tags']
    video['descr'] = result['items'][0]['snippet']['description']
    video['content'] = result['items'][0]['contentDetails']
    video['stats'] = result['items'][0]['statistics']
    
    return video
    

def video_comments(video_id, max_results = 10):
    
    # Call the comments.list method to retrieve video comments
    results = youtube.commentThreads().list(
        videoId = video_id,
        part = "id,snippet",
        order = "relevance",
        textFormat = "plainText",
        maxResults = max_results%101
    ).execute()

    comments = []
    
    # Extracting required info from each result
    for result in results['items']:
        comment = {}
        comment['id'] = result['id']
        comment['text'] = result['snippet']['topLevelComment']['snippet']['textOriginal']
        comment['likes'] = result['snippet']['topLevelComment']['snippet']['likeCount']
        comments.append(comment)
    
    return comments
    

if __name__ == "__main__":
    video_id = "vTaxdJ6VYWE"
    
    details = video_details(video_id)
    comments = video_comments(video_id)
    
    pprint(details)
    pprint(comments)
```

The details of the video fetched using above script looks like this:
```
{'content': {'caption': 'false',
             'definition': 'hd',
             'dimension': '2d',
             'duration': 'PT1H26M22S',
             'licensedContent': True,
             'projection': 'rectangular'},
 'descr': 'Although numeric data is easy to work with in Python, most '
          'knowledge created by humans is actually raw, unstructured text. By '
          'learning how to transform text into data that is usable by machine '
          'learning models, you drastically increase the amount of data that '
          "your models can learn from. In this tutorial, we'll build and "
          'evaluate predictive models from real-world text using scikit-learn. '
          '(Presented at PyData DC on October 7, 2016.)\n'
          '\n'
          'GitHub repository: '
          'https://github.com/justmarkham/pydata-dc-2016-tutorial\n'
          'Enroll in my online course: http://www.dataschool.io/learn/\n'
          'Subscribe to the Data School newsletter: '
          'http://www.dataschool.io/subscribe/\n'
          '\n'
          '== OTHER RESOURCES ==\n'
          'My scikit-learn video series: '
          'https://www.youtube.com/playlist?list=PL5-da3qGB5ICeMbQuqbbCOQWcS6OYBr5A\n'
          'My pandas video series: '
          'https://www.youtube.com/playlist?list=PL5-da3qGB5ICCsgW1MxlZ0Hq8LL5U3u9y\n'
          '\n'
          '== JOIN THE DATA SCHOOL COMMUNITY ==\n'
          'Blog: http://www.dataschool.io\n'
          'Newsletter: http://www.dataschool.io/subscribe/\n'
          'Twitter: https://twitter.com/justmarkham\n'
          'YouTube: https://www.youtube.com/user/dataschool?sub_confirmation=1',
 'stats': {'commentCount': '32',
           'dislikeCount': '0',
           'favoriteCount': '0',
           'likeCount': '62',
           'viewCount': '2828'},
 'tags': ['python',
          'data science',
          'machine learning',
          'natural language processing',
          'text analysis',
          'scikit-learn'],
 'title': 'Machine Learning with Text in scikit-learn (PyData DC 2016)'}
```

Also, one of the comment elements looks like this:
```
{'id': 'z135ix34vmvcwtwug22iidozxmzexdei304',
  'likes': 0,
  'text': 'Thank you Kevin! Such informed tutorial with great details but not '
          'redundant!'}
``` 

In above code,


- we used **videos.list** method to retrieve all metadata about the video by simply passing its *id* to the **video_details** function.
- Similarly, we used **commentThreads.list** method to retrieve all metadata about comments under a video by simply passing 
  video id to the **video_comments** function.

**Note:** The above two examples are intended to get you comfortable with the google-api-python-client and YouTube Data API. You can refer to [YouTube Data API docs](https://developers.google.com/youtube/v3/docs/) to implement more methods which involve fetching data from YouTube.

So far, we have just seen how to **fetch** various types of data from YouTube Data API. 
In next parts of this tutorial series, we will see how to manipulate the YouTube user data on YouTube using this API.



