export class RoomChannel{

    static setup_and_join(socket, room_id){

        let room_channel = socket.channel(`room:${room_id}`)

        

    }

}