export class LobbyChannel{

    static setup_and_join(socket, user_id){

        let lobby_channel = socket.channel("lobby", {user_id: user_id})

        // Create New Room button press
        document.getElementById("create-btn").addEventListener("click", e => {

            lobby_channel.push("create_room")
                .receive("room_created", (resp) => {
                        console.log(resp)
                        // Navigate to /room, use resp.room_id, resp.room_code
                    })

        })
        
        // Join Room button press
        document.getElementById("join-existing-btn").addEventListener("click", e => {

            let room_code = document.getElementById("room-code-input").value

            lobby_channel.push("join_existing_room", {room_code: room_code})
                .receive("invalid_code", (resp) => {
                    console.log("invalid, ", resp)
                })
                .receive("valid_code", (resp) => {
                    console.log("valid, ", resp)
                })

        })

        // Join Stranger button press
        document.getElementById("match-stranger-btn").addEventListener("click", e => {

            lobby_channel.push("match_with_stranger", {test: "test"})
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

        lobby_channel.join()

        return lobby_channel

    }

}