---
layout: post
title: "Modelling environments in NetLogo for intelligent agents"
description: "Creating AI agents using the NetLogo platform"
headline: "Creating AI agents using the NetLogo platform"
modified: 2017-02-20 18:23:30 +0530
category: "Artificial Intelligence"
tags: ["artificial intelligence", "machine learning", "netlogo"]
author: "Sagar Mohan"
feature-img: 
mathjax: 
chart: 
comments: true
featured: false
---
## Theory

We live in a time and a world where AIs (I'll refer to an artificially intelligent entity as an agent in this blog) are becoming more and more prevalent in day to day life. Agents are being used everywhere, in our daily life we come across a machine which has to make decisions; it has to decide what the most well-established path is, and whether it should take it. It does this by considering its previous history; its interaction with the environment and the various mathematical sequences, combinations and pairs of percepts and actuators it has to assemble.

Hope you're still with me. Stick with me, I promise it'll be worth your time.

Let's break this down with a simple example. Consider a Mars rover. This rover has the job of autonomously gathering pieces of rock found on Mars. How does it do that, you ask? Let's contemplate this:

- It has a camera - _a sensor_ which perceives the environment
- It has a claw - an _actuator_ which can be used for the rover to grab onto the pieces of rock

So essentially, it goes around an area on Mars, geographically cordoned off by space scientists using coordinates, it uses its camera to find pieces of rock and it uses its grabber to grab those samples.

So, this is simple right? Right! But hold on a moment, chances are you didn't come to this blog to find out about a Mars rover. Surely we can improve on this idea - what if we wanted to artificially induce this rover with some simple thinking patterns? Wouldn't it be much better if it knew that a specific area has a large number of samples as opposed to it aimlessly travelling around Mars? Wouldn't it be better if it could use its previous history of actions to determine these areas and this would save money (space-stuff isn't cheap) and time.

Have you ever wondered where and how these agents are modelled? I.e. In what type of environment agents can operate in (static/dynamic, discrete/continuous, observable/partially observable, single or multi-agents operating together, deterministic/non-deterministic, episodic/non-episodic - chances are, if you're reading this blog then you know what I mean by these properties, so I won't delve into them in detail).

It turns out, if you're an inquisitive mind and you want to model an environment where agents can be utilised to solve problems, you can do exactly that with the use of a simple but powerful programming environment in _NetLogo_.

## NetLogo

Here comes the fun stuff. Roll up your sleeves. So, going back to our previous Mars rover
 example, how would we do this in NetLogo? NetLogo uses a simple system where you have:

- An Observer
  - Gives instructions to other agents
- Turtles
  - The agents. They move around the environment carrying out specific actions set
  to them by the programmer. In our example, the turtle is the Mars rover.
- Patches
  - Each patch has coordinates. So in essence, an environment is made up of a grid of
  patches. Our environment will simply be made up of square pieces of ground on Mars,
   with some special patches which will contain the samples that need to be collected by
   the rover.

OK. So we can pretty easily build an environment where a turtle (our Mars rover) goes around,
 navigating the environment and if it just so happens to be standing over special patch, it'll
 pick up a sample. Below is some sample NetLogo code illustrating how the rover would do this:

```
let move random 3

**if**  not next\_rock

  ** **** i ****f**  (move = 0)[]

   **if**  (move = 1)[left-turn]

   **if**  (move = 2)[right-turn]

  go-forward

   **if**  next\_rock? [grabrock]
```

An extremely basic example where, we have a random variable, _move_, which checks
if there's a rock on an adjacent patch which the turtle is currently on, if it doesn't
then it moves randomly around the environment, if it does, then it calls a function which
grabs the rock.

### Modelling intelligent agents

But how do we make it _clever_, how do we add some _intelligent behaviour_? To do this,
first we need to talk about the Markov Decision Process, or MDP. Briefly, this is a mathematical
 framework which models decision making in situations where outcomes are partly random and partly
 under the control of the decision maker. More specifically, quoting Wikipedia, &quot;More precisely,
 a Markov Decision Process is a  [discrete time](https://en.wikipedia.org/wiki/Discrete_time)
  [stochastic](https://en.wikipedia.org/wiki/Stochastic)
   [control](https://en.wikipedia.org/wiki/Optimal_control_theory)
    process. At each time step, the process is in some state, _s_, and the decision
    maker may choose any action _a_, that is available in state, _s_.
     The process responds at the next time step by randomly moving into a new state, _s'_,
     and giving the decision maker a corresponding reward.&quot;

Let's put this idea to practice in NetLogo. So in essence, we need to give each patch in the environment a value, and this value needs to vary depending on whether there are a large number of samples available around it. I.e. a patch which has no samples in close vicinity will not have a large value associated with it and a patch which has for example, 5 or 6 rocks in a 5-patch radius, it will have a pretty large value. The turtle then navigates around the environment by picking the patches with the highest values.

Got it? Let's move on.

So there's two main things we need to do here; we need to set the values of the patches according to where the rocks are located (we do this by using something called the Bellman equation), and then we need to make the agent behave accordingly. Let's do the former first.

The Bellman equation is a way of optimising mathematical expressions and solving decision problems in terms of some initial choices and the value of the remaining decision problems that result from those initial choices.

U(s)=R(s)+γmax∑s'P(s'|s,a)U(s')

It looks pretty technical. But it's not. I'll let you read about the equation in your own time.

First, we need to initialise some values:

```
ask patches[
  set value 0
]
let r -0.04
let gamma 1
ask patches [
   **if**  rock[
    set value 1
  ]
let north\_value 0
let south\_value 0
let west\_value 0
let east\_value 0
let max\_v 0
```

Above, all I'm doing is setting the reward to -0.04 and the gamma to 1 for use in the Bellman equation. All the patches are being set to 0, and then later in line 7, any patches that have rocks in them are being set to 1.

So, now we can use the Bellman equation to set the values of the patches associated in the environment. We do this as so:

```
   **while**  [x &lt; 20][

    ask patches[

      set north\_value 0

      set south\_value 0

      set west\_value 0

      set east\_value 0

       **if**  not next\_rock

      [

         **if**  pycor != 8 [

          ask patch pxcor (pycor + 1)[

            set north\_value value]

          ]

         **if**  pycor != -8 [

          ask patch pxcor (pycor - 1)[

            set south\_value value]

          ]

         **if**  pxcor != -8 [

          ask patch (pxcor - 1) pycor[

            set west\_value value]

          ]

         **if**  pxcor != 8 [

          ask patch (pxcor + 1) pycor[

            set east\_value value]

          ]

        set max\_v max(list north\_value south\_value west\_value east\_value)

        set value r + gamma \* max\_v

      ]
    ]
    set x x + 1
  ]
]
```


So,  as I said it's pretty simple. All we're doing here is setting the north, south, east and west values to zero initially and then we're asking the adjacent patches their values and setting them. Because we're using a deterministic value iteration, we can ignore the summation part of the Bellman equation. At line 26, we're using the Bellman equation to set the value of the patch.

Note: the reason for using 20 in that while loop is because it takes around 17 or so iterations for the grid to populate itself with the patch values - _read: Bellman equation_, and the reason for the if conditions having -8 and 8 values is because I set the NetLogo grid to be 16x16, with an origin in the middle, and so we can't calculate the values outside those boundaries.

So lastly, we can now create a control program for our Mars rover. Below shows the deterministic control program for the Mars rover simply makes the agent look around its current patches and pick the patch with the maximum value and head in that direction.

```
  let moves []

  let max\_m []

  let m 0

  set moves (list north-value south-value east-value west-value)

  set m max(moves)

  let r 0

  let i 0

    foreach moves[

    set i i + 1

     **if**  ? = m[

      set max\_m fput i max\_m

    ]

  ]

  ifelse length max\_m = 1[

     **if**  item 0 max\_m = 1[

      north

    ]

     **if**  item 0 max\_m = 2[

      south

    ]

     **if**  item 0 max\_m = 3[

      east

    ]

     **if**  item 0 max\_m = 4[

      west

    ]

  ]

  [

    set r random length max\_m

     **if**  (item r max\_m) = 1 [north]

     **if**  (item r max\_m) = 2 [south]

     **if**  (item r max\_m) = 3 [east]

     **if**  (item r max\_m) = 4 [west]

  ]

   **if**  next\_rock

  [grab-rock]

  set renew?  **true**

```


The max\_m variable is a list which will store the maximum value.
The reason for the list is that if there is more than 1 maximum value,
we can store them in a list and then move in a random direction out of all of
 the maximum values. In line 4, the moves variable stores the values of the north,
 south, east and west patches. The m variable in line 5 sets the patch with the max
 value from the patches in the north south east and west direction.

From lines 8 to 13, this loop will store the max patches in a list.
The i index will refer to which patch has been saved in the list.
If 1 has been saved for example, this will mean the max patch value is north.
If 2 is saved this will mean south (referring to the order in which the moves list is saved).

The block of if-statements with the condition at line 15, is checking if
the list of the max values contains more than one value. If it does, this means
 there is one max value stored and that we have one definitive direction to head in.
  From lines 16 to 18, the index here refers to which max patch value is saved in the list,
  in this case 1 is saved therefore north is the max value. The agent will head north.
  From lines 19 to 21, we are checking if the item stored in the list is a 2, and
   if it is we will head south. From lines 22 to 24, the same if being done for east and from
    lines 25 to 26 the same is being done for the west.

From lines 30 to 35, we're in the situation where more than 1 max value has been stored in the max\_m list. Here we choose a random direction to head in (from the maximum values) as there are 2 or more values to decide from. At line 30, we have set the variable r as a random number between the length of the list max\_m and 1, i.e. if there are 3 max values, r can be 0, 1 or 2. At line 31, we're checking if the random index number refers to 1 in the list max\_m then the agent will go north. At 32 we're doing the same for south, 33 is the same for east and 34 is the same for west.

Try it out! The above can be implemented pretty easily if you take a holistic approach to all the code that I've written above.

This brings me to the last part of this _terribly_ long blog (apologies!). But I hope you stuck with me to the end. I wanted to demonstrate the fact that AIs are important and all, but we first need to decide what we're going to do with them. We need to calculate mathematically how we're going to put them in practice. We need to be clever, before attempting to build something clever, no? NetLogo allows you to do exactly this, and I hope, after this blog post you feel inspired to go create your own model on NetLogo and share it with the world, or go and look at some existing ones and see how you can improve them further.


