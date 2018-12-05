# Skydock

Skydock is a service that allows users to send commands via Twilio SMS to a Docker server, whether the network is public or private.

In order to receive texts from Twilio, we must establish a webhook for Twilio to send them to. Due to development and evaluation on private networks (behind NAT), we use the "ngrok" service inside docker-compose.yml. Ngrok gives us our own unique URL, in our case https://skydock.ngrok.io, whose traffic is forwarded down to our local machine.

tl;dr; ngrok lets us act like we have a public ip

## Running Skydock

### System Requirements
- Internet Connection
- Docker
- Docker Compose (bundled with Docker for Mac)

### Accounts Needed
- Twilio Programmable SMS
- Ngrok

### Environment Variables
In the project root, create a secrets.env file for docker-compose with the following keys:
- TWILIO_ACCOUNT_SID
- TWILIO_AUTH_TOKEN
- NGROK_AUTH
- NGROK_SUBDOMAIN
- NGROK_PORT=skydock:80

[Note to Prof. Thomas] This secrets.env will be linked in a private repo.

### Twilio Config
Make sure Twilio SMS is set to forward messages to the ngrok URL

### Runnning the Progam
`docker-compose up`
As long as your mobile phone is confirmed to reveive SMS messages from the Twilio service, you may send the following commands:
- get containers
- start <container>
- start <container>
- kill <container>
- pause <container>
- unpause <container>
- get images
- create image <name> <tag>
- system

Responses are generally very quick, except for certain Docker operations that hang.

Note: skydock gives you access to your own machine's docker server, unless yo run it remotely. You can technically even send an SMS call to shutdown itself by sending the SMS `kill skydock`. THis is because the skydock_service container has a pointer to the real docker socket.