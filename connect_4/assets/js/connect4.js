import { Socket } from "phoenix"

export class Connect {
    
    

    constructor() {
        this.channel = this.join_channel()
        console.log("Started Connect 4 Game");
        
        this.setupEventHandlers()

    }

    join_channel() {
        let socket = new Socket("/socket")
        socket.connect()

        let channel = socket.channel("c4:common")
        channel.join()

        return channel
    }

    setupEventHandlers() {
        var arr = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"];
        var board = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
        var turn = 0;

        

        document.body.addEventListener("click", ev => {
            // console.log(ev.target.id);
            var targ = ev.target.id;
            if(arr.includes(targ)) {
                var intTarg = parseInt(targ);
                if(turn == 0) {
                    ev.target.style.backgroundColor = "red";
                    turn = 1
                } else {
                    ev.target.style.backgroundColor = "blue";
                    turn = 0;
                }
                
            }

            

        })
    }

    



}