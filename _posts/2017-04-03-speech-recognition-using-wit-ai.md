---
layout: post
title: "Speech Recognition using Wit.ai"
description: "Speech Recognition using Wit.ai"
headline: "Speech Recognition using Wit.ai"
modified: 2017-04-03 12:13:12 +0530
category: [Tutorial]
tags: [speech-recognition, wit, python]
feature-img: "img/post/wit-speech-api/recognizespeech.png"
author: Nikhil Kumar Singh
mathjax: 
chart: 
comments: true
featured: false
---

**[Wit.ai](https://wit.ai/)** is a **NLP (natural language processing)** interface for applications capable of turning sentences into structured data. And most importantly, it is free! So, there are no API call limits! 

Wit.ai API provides many kind of NLP services including **Speech Recognition**.

In this article, I am going to show how to consume the **[Wit Speech API](https://wit.ai/blog/2014/02/12/speech-api)** using Python with **minimum dependencies**.

### Step 1: Create an API Key

In order to use Wit.ai API, you need to create a Wit.ai app. Every Wit.ai app has a **server access token** which can be used as an API Key.

Follow these steps to create a Wit.ai app and generate API Key:

- Go to [Wit.ai home page](https://wit.ai/) and sign in with your GitHub or Facebook account.
- Click on '**+**' sign in menu bar on top and create a new app.
- Now, open the app dashboard and got to **Settings** of your app.
- In **Settings**, under **API Details**, copy the **Server Access Token** and use it as API key.


### Step 2: Python script to record audio

Obviously, we need to pass audio data to the Wit API for speech recognition. For this, we create a Python script to record audio from microphone.

For this purpose, we will be using **[PyAudio](https://people.csail.mit.edu/hubert/pyaudio/docs/)** module.

#### Installations

- **Windows**: Just install **PyAudio** module using a simple pip command:
  ```
  pip install pyaudio
  ```
- **MAC OS X**: Install **portaudio** library using Homebrew and then install **PyAudio** module using pip:
  ```
  brew install portaudio
  pip install pyaudio
  ```
- **Linux**: Install **portaudio** library development package using this command:
  ```
  sudo apt-get install portaudio19-dev
  ```
  Then, install **PyAudio** module using pip:
  ```
  pip install pyaudio
  ```
  
Now, consider the code below to record audio from microphone:


```python
import pyaudio
import wave


def record_audio(RECORD_SECONDS, WAVE_OUTPUT_FILENAME):
    #--------- SETTING PARAMS FOR OUR AUDIO FILE ------------#
    FORMAT = pyaudio.paInt16    # format of wave
    CHANNELS = 2                # no. of audio channels
    RATE = 44100                # frame rate
    CHUNK = 1024                # frames per audio sample
    #--------------------------------------------------------#
     
    # creating PyAudio object
    audio = pyaudio.PyAudio()
     
    # open a new stream for microphone
    # It creates a PortAudio Stream Wrapper class object
    stream = audio.open(format=FORMAT,channels=CHANNELS,
                        rate=RATE, input=True,
                        frames_per_buffer=CHUNK)


    #----------------- start of recording -------------------#
    print("Listening...")

    # list to save all audio frames
    frames = []

    for i in range(int(RATE / CHUNK * RECORD_SECONDS)):
        # read audio stream from microphone
        data = stream.read(CHUNK)
        # append audio data to frames list
        frames.append(data)

    #------------------ end of recording --------------------#   
    print("Finished recording.")
      
    stream.stop_stream()    # stop the stream object
    stream.close()          # close the stream object
    audio.terminate()       # terminate PortAudio

    #------------------ saving audio ------------------------#

    # create wave file object
    waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')

    # settings for wave file object
    waveFile.setnchannels(CHANNELS)
    waveFile.setsampwidth(audio.get_sample_size(FORMAT))
    waveFile.setframerate(RATE)
    waveFile.writeframes(b''.join(frames))

    # closing the wave file object
    waveFile.close()


def read_audio(WAVE_FILENAME):
    # function to read audio(wav) file
    with open(WAVE_FILENAME, 'rb') as f:
        audio = f.read()
    return audio
```

Here, we use PyAudio file to record audio in **WAV** format. 

For writing audio stream to a **WaveFile**, we use in-built Python library **[wave](https://docs.python.org/3/library/wave.html)**. Once audio is recorded using PyAudio, it is saved as a **wav** file in current directory.

Save this Python script as **Recorder.py** (as we will import this Python script by this name in main Python script).

### Step 3: Python script to interact with Wit Speech API

Now, its time to write Python script for interacting with **Wit Speech API**.

Consider the code below:


```python
import requests
import json
from Recorder import record_audio, read_audio

# Wit speech API endpoint
API_ENDPOINT = 'https://api.wit.ai/speech'

# Wit.ai api access token
wit_access_token = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX'


def RecognizeSpeech(AUDIO_FILENAME, num_seconds = 5):
    
    # record audio of specified length in specified audio file
    record_audio(num_seconds, AUDIO_FILENAME)
    
    # reading audio
    audio = read_audio(AUDIO_FILENAME)
    
    # defining headers for HTTP request
    headers = {'authorization': 'Bearer ' + wit_access_token,
               'Content-Type': 'audio/wav'}

    # making an HTTP post request
    resp = requests.post(API_ENDPOINT, headers = headers,
                         data = audio)
    
    # converting response content to JSON format
    data = json.loads(resp.content)
    
    # get text from data
    text = data['_text']
    
    # return the text
    return text


if __name__ == "__main__":
    text =  RecognizeSpeech('myspeech.wav', 4)
    print("\nYou said: {}".format(text))
```

**Wit Speech API** accepts HTTP POST request.

The POST request must contain:
- **headers**
  ```
  headers = {'authorization': 'Bearer ' + wit_access_token,
               'Content-Type': 'audio/wav'}
  ```
  where **wit_access_token** is the API Key we generated in **Step 1**.
- **data**
  ```
  data = audio
  ```
  The data to be passed is the audio stream in wav format. As you can notice, the recorded audio is saved in a file
  called **myspeech.wav**. We read audio back again form this file using **read_audio** method. 
  
And we send this HTTP request to this endpoint: [https://api.wit.ai/speech](https://api.wit.ai/speech)

A sample response of HTTP request looks like this:
```
{u'_text': u'hey how are you',
 u'entities': {},
 u'msg_id': u'1ca8f790-4e83-443c-915c-914bc1a42100'}
```

Wit.ai is not just limited to speech recognition. 

It also allows you to create a **chatbot** which can recognize any user-defined **entity** in the provided text! Since I have not created any enitities for my current Wit app, the **entities** section of HTTP response is empty.

Github repository: [Wit Speech API Wrapper](https://github.com/nikhilkumarsingh/Wit-Speech-API-Wrapper/tree/master)

Here is a demo video of how above scripts work:

<iframe width="560" height="315" src="https://www.youtube.com/embed/hgG7xyGmKb0" frameborder="0" allowfullscreen></iframe>
