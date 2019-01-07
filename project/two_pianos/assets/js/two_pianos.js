import { Socket } from "phoenix"
import { Piano }  from "./piano"

export class TwoPianos{
    
    constructor(){

        // Fetch embedded user_id from window (generated by backend)
        this.user_id = window.user_id
        console.log(`user_id: ${this.user_id}`)

        // Set up socket
        this.socket = new Socket("/socket")
        this.socket.connect()

        // Init and join lobby and user channels
        this.channels = {}

        this.channels.lobby = this.socket.channel("lobby", {user_id: this.user_id})
        this.channels.lobby.join()

        this.channels.user  = this.socket.channel(`user:${this.user_id}`)
        this.channels.user.join()

        // Create User's piano (lobby)
        this.pianos        = {}
        this.pianos.mine   = new Piano(1)
        this.pianos.theirs = null

        this.setupLobbyHandlers()
        this.setupUserHandlers()
    }

    setupLobbyHandlers(){
        // SENDERS

        // on "Create New Room" button press
        document.getElementById("create-btn").addEventListener("click", e => {

            this.channels.lobby.push("create_room")
            .receive(
                "room_created", (resp) => {
                    console.log(resp)
                    // Navigate to /room, use resp.room_id, resp.room_code
                }
            )

        })
        
        // on "Join Room" button press
        document.getElementById("join-existing-btn").addEventListener("click", e => {

            let room_code = document.getElementById("room-code-input").value

            this.channels.lobby.push("join_existing_room", {room_code: room_code})
                .receive("invalid_code", (resp) => {
                    console.log("invalid, ", resp)
                })
                .receive("valid_code", (resp) => {
                    console.log("valid, ", resp)
                })

        })

        // on "Join Stranger" button press
        document.getElementById("match-stranger-btn").addEventListener("click", e => {

            this.channels.lobby.push("match_with_stranger", {test: "test"})
                .receive("waiting", (resp) => {
                    console.log("waiting")
                })
                .receive("already_waiting", (resp) => {
                    console.log("already waiting")
                })
                .receive("match", (resp) => {
                    console.log(`Match! ${resp.room_id}`)
                })
        })

    }

    setupUserHandlers(){

        // on "match_found"
        this.channels.user
            .on("matched_user", (msg) => {
                console.log("Matched!", msg.room_id)
            })

    }

}