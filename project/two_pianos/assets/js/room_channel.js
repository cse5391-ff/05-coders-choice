import { Piano } from "./piano"

export class RoomChannel{

    static setup_and_join(socket, user_id, room_id, their_piano){

        let room_channel = socket.channel(`room:${room_id}`)
        let keycodes     = Piano.get_keycodes()

        document.addEventListener('onkeydown', function(e){
            e = e || window.event
    
            if (!e.repeat && e.keyCode in keycodes && !(input === document.activeElement)){
                room_channel.push("keys_pressed", {keys_pressed: keycodes[e.keyCode]})
            }
        })

        document.addEventListener('onkeyup', function(e){
            e = e || window.event
    
            if (e.keyCode in keycodes && !(input === document.activeElement)){
                room_channel.push("keys_released", {keys_released: keycodes[e.keyCode]})
            }
        })

        document.getElementById("message-post-btn").addEventListener("click", e => {

            let message = document.getElementById("message-input").value

            if (message !== ""){
                room_channel.push("message_posted", {message_posted: message})
                RoomChannel.render_message("you", message)
            }

        })

        room_channel.on("keys_pressed", (resp) => {
            their_piano.press(resp.keys_pressed)
        })
            
        room_channel.on("keys_released", (resp) => {
            their_piano.release(resp.keys_released)
        })

        room_channel.on("message_posted", (resp) => {
            RoomChannel.render_message("them", resp.message_posted)
        })

        room_channel.join()
            .receive("ok", resp => {
                console.log("Room Channel: Joined successfully", resp) 
            })
            .receive("error", resp => { 
                console.log("Room Channel: Unable to join", resp) 
            })
            
        return room_channel
        
    }

    static render_message(you_or_them, message) {
        let chat_box       = document.getElementById("chat-box")
        let message_block  = document.createElement('p')

        message_block.insertAdjacentHTML('afterbegin', `<b>${you_or_them === 'you' ? '(:' : ':)'}</b>${message}`)
        chat_box.appendChild(message_block)
    }

}