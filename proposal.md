Name: Lucas Hansen           ID:   4666-0800

# Proposed Project

## SkyDock

For my project, SkyDock, I would like to create a hub for administration of machines running Docker containers. This service would allow users to remotely check system/container health reports as well as start, stop, or modify existing containers. The first iteration of this project will involve the creation of Elixir applications used to interact with Docker and interpret results from Docker commands (essentially an elixir wrapper around some of the functionality of Docker). The second iteration will be to add SMS functionality in a separtate module. 

As time permits, the third iteration would be to add a Phoenix webserver to expose a webhook to Twilio in order to eliminate SMS message polling. This "master server" must be on a static public IP, and will receive delegate commands (elixir messages) to machines "subscribed" to it. The addition of this webserver could also allow users to interact with Docker via a web interface. If the webserver is not added, users will only be able to send text commands to a single machine that is constantly polling for new commands, but if the machines do not have a dedicated IP, it will still work, because messages will be received from Twilio via polling and not webhooks.  

# Outline Structure

Code will be organized into the following Modules 

## Iteration 1:
- Docker API - An interface for interacting with Docker via a linux shell
- System API - Interface for fetching system/environment details
- Config API - Static information, set at runtime 
- Note: Iteration 1 will not be useful to an end-user on it's own

## Iteration 2:
- TwilioPoller - process that will poll Twilio for new messages
- MessageHandler - Parses SMS messages and delegates them to the Docker API
- MessageManager - process that will interact with Ecto/Sqlite to keep track of messages that have been received and processed
- TwilioSender - process that handles sending SMS responses to the user via the Twilio REST API

## Iteration 3:

### Master Service:
- TwilioWebhook - Phoenix process that will expose a webhook to receive new SMS messages
- MessageHandler - Parses SMS messages and delegates them to the respective machine via GenServer
- MessageManager - will be updated to a Postgres DB, something a bit beefier than sqlite
- TwilioSender - process that handles sending SMS responses to the user via the Twilio REST API

### Subscriber Service:
- MasterListener - process run on an individual machine running Docker, this process establishes a connection with the master server and identifies itself. 
- API's developed in Iteration 1 to handle the commands received through the MasterListener

## More Stretch Goals
- Generate and respond with MMS .png/.jpg images for system/container health data over time. Would need to add another process that builds up a timeline of system/container health data:
- Send a text message if a contianer errors, or system load reaches a threshhold