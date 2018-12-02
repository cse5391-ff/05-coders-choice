import { Socket } from "phoenix";

export default class TwoPianosSocket {

    constructor() {
        this.socket = new Socket("/socket", {})
        this.socket.connect()
    }

    connect_to_lobby() {
        this.setup_channel()
        this.channel.on(" ")
    }

    setup_channel() {
        this.channel = this.socket.channel("two_pianos:lobby", {})

        this.channel
            .join()
            .receive("ok", resp => {
                console.log("connected: " + resp)
            })
            .receive("error", resp => {
                alert(resp)
            })

    }

}