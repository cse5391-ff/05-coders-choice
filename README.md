# Scope
A modern digital communications framework

## Creating a channel
To create a channel, enter the command:
```Elixir
Scope.ChatServer(:new, topic)
```
This subscribes a new server to the given topic.
## Joining a channel
In joining a channel, list the available topics and
select the channel which you would like to join using:
```Elixir
User.request(:req, topic, key)
```
## Sending a message
In sending a message to a server, a user selects the topic with which they wish to send to (which they must be joined to):
### With urgent status
```Elixir
User.send_msg(topic, message, :urgent)
```
These messages are highlighted at the bottom of the inbox with a "! - Message Content" format.
### With peripheral status
```Elixir
User.send_msg(topic, message, :peripheral)
```
These messages are processed with a [*****] count based on the amount of messages available, to indicate a "peripheral awareness" notification system.
### With normal status
```Elixir
User.send_msg(topic, message, :normal)
```
These messages are tallied in a [XX] format.
## Viewing inbox
To view the user's inbox, enter the command:
```Elixir
User.request(:inbox, topic)
```