# Scope

A modern digital communications framework

## Setup

Run ```mix deps.get``` and (switch to your assets folder) and run ```npm install``` to install dependencies, then run ```mix ecto.create``` and ```mix ecto.migrate``` to create your db.



Run ```mix phx.server``` to run the app.

## Instructions

##### Create a new channel

  by clicking the "+ add new" icon

  type in your channel name ( e.g. "chatroom112")

#####  Join a channel

  by clicking the left icon you would like to join

##### Send a message
  by entering your username

  selecting an urgency level(normal - "", peripheral - "*", urgent - "!")

  type your message and press enter

##### View all unread messages in the side panel

  View your inbox by clicking on the channel name on the left-hand side.

  Channel automatically updates to reflect read messages

### Cautions:
  Add new channel is buggy, would recommend using the in use channels

  Message updates cross browser come after rejoining channel.
