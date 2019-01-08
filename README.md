# Scope

A modern digital communications framework

## Setup

Run ```mix deps.get``` and (switch to your assets folder) and run ```npm install``` to install dependencies, then run ```mix ecto.create``` and ```mix ecto.migrate``` to create your db.



Run ```mix phx.server``` to run the app.

## Instructions

**Create a new channel:**

Click the "+ add new" icon

Type in your channel name ( e.g. "chatroom112")


**Join a channel:**

Click the left icon you would like to join


**Send a message:**

Enter your username

Select an urgency setting(normal - "[blank]", peripheral - "*", urgent - "!")

Type your message and press enter


**View all unread messages in the side panel:**

Click the channel name on the left-hand side.

Channel automatically updates to reflect read messages


### Cautions:
  - Add channel is buggy, I would recommend using the in use channels.

  - Message sending cross browser responds after rejoining channel.
