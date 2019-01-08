export class LobbyChannel{

    static setup_and_join(socket, user_id){

        let lobby_channel = socket.channel("lobby", {user_id: user_id})

        // Create New Room button press
        document.getElementById("create-btn").addEventListener("click", e => {

            lobby_channel.push("create_room")
                .receive("room_created", (resp) => {

                    console.log(`Lobby Channel: Room Created\nroom_id: ${resp.room_id}, room_code: ${resp.room_code}`)

                    localStorage.setItem("room_id", resp.room_id)

                    setTimeout(function(){
                        window.location.replace("http://localhost:4000/room")
                    }, 2000)

                })

        })
        
        // Join Room button press
        document.getElementById("join-existing-btn").addEventListener("click", e => {

            let room_code = document.getElementById("room-code-input").value

            lobby_channel.push("join_existing_room", {room_code: room_code})
                .receive("invalid_code", (resp) => {

                    console.log(`Lobby Channel: Join Existing\ninvalid code ${room_code}`)

                })
                .receive("valid_code", (resp) => {

                    console.log(`Lobby Channel: Join Existing\nvalid code ${room_code}, connecting to room ${resp.room_id}`)

                    localStorage.setItem("room_id", resp.room_id)

                    setTimeout(function(){
                        window.location.replace("http://localhost:4000/room")
                    }, 2000)

                })

        })

        // Join Stranger button press
        document.getElementById("match-stranger-btn").addEventListener("click", e => {

            lobby_channel.push("match_with_stranger", {test: "test"})
                .receive("waiting", (resp) => {

                    console.log("Lobby Channel: Match With Stranger\nWaiting")

                })
                .receive("already_waiting", (resp) => {

                    console.log("Lobby Channel: Match With Stranger\nAlready Waiting")

                })
                .receive("match", (resp) => {

                    console.log(`Lobby Channel: Match With Stranger\nMatch, room_id: ${resp.room_id}`)

                    localStorage.setItem("room_id", resp.room_id)

                    setTimeout(function(){
                        window.location.replace("http://localhost:4000/room")
                    }, 2000)

                })
        })

        lobby_channel.join()

        return lobby_channel

    }

}