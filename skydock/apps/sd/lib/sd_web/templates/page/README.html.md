# Skydock

Skydock is a service that allows users to send commands via Twilio SMS to a Docker server, whether the network is public or private. Since it would be too complex for the user to use super long docker commands, Skydock uses a very simple syntax, and It should be noted that these commands do not use the same language constructs as the Docker CLI (see below).

In order to receive texts from Twilio, we must establish a webhook for Twilio to send them to. Due to development and evaluation on private networks (behind NAT), we use the "ngrok" service inside docker-compose.yml. Ngrok gives us our own unique URL, in our case https://skydock.ngrok.io, whose traffic is forwarded down to our local machine.

tl;dr; ngrok lets us act like we have a public ip

# User Docs

## System Requirements
- Internet Connection
- Docker
- Docker Compose (bundled with Docker for Mac)

## Accounts Needed
- Twilio Programmable SMS
- Ngrok
[Note to @pragdave] See Note Below

## Environment Variables
In the project root, create a secrets.env file for docker-compose with the following keys:
- TWILIO_ACCOUNT_SID
- TWILIO_AUTH_TOKEN
- NGROK_AUTH
- NGROK_SUBDOMAIN
- NGROK_PORT=skydock:80

[Note to @pragdave] This secrets.env file and the phone number to text commands can be found [here](https://github.com/lchansen/skydock_secrets)

## Runnning the Progam
`docker-compose up`

[Note to @pragdave] If you have some running containers you wish to experiment on, feel free. Else, you can spool up some containers by running an app I found (Github: dockersamples/example-voting-app) by typing `docker-compose up` in the sample_containers directory.

## Using the Program
As long as your mobile phone is confirmed to reveive SMS messages from the Twilio service, you may send the following commands:
```
get containers

logs <container friendly name> # Replies with a MMS image of log tail

system

start <container name>

stop <container name>

kill <container name>

pause <container name>

unpause <container name>
```


Responses are generally very quick, except for certain Docker operations that hang.

Note: skydock gives you access to your own machine's docker server, unless you run it remotely. You can technically even send an SMS call to shutdown itself by sending the SMS `kill skydock_service`. This is because the skydock_service container has a pointer to the real docker socket.

## Example
After running the sample_containers app, text `get containers` to the phone number provided. If a container exists with the frindly name "samplecontainers_worker_1", you could check its logs by typing `logs samplecontainers_worker_1`. If you wanted to resrart it, you could send `stop samplecontainers_worker_1` and then `start samplecontainers_worker_1`. Experiment with any way you would like. 