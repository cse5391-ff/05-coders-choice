# Coder's Choice

See the assignment on Canvas for details

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
```Elixir
User.send_msg(topic, message, status)
```
### With urgent status
User.send_msg(topic, message, :urgent)
### With peripheral status
User.send_msg(topic, message, :peripheral)
### With normal status
User.send_msg(topic, message, :normal)

## Viewing inbox
To View a User Inbox, enter 
```Elixir
User.request(:inbox, topic)
```