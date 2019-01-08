export class UserChannel{

    static setup_and_join(socket, user_id){

        let user_channel = socket.channel(`user:${user_id}`)

        // when another user connects to you after you hit "join stranger" button
        user_channel.on("matched_user", (msg) => {

            console.log(`Matched! ${msg.room_id}`)

            localStorage.setItem("room_id", msg.room_id)

            setTimeout(function(){
                window.location.replace("http://localhost:4000/room")
            }, 2000)
            
        })

        user_channel.join()

        return user_channel

    }

}