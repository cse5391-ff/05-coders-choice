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
        var arr = ["c0","c1","c2","c3","c4","c5"];
        var board = [
            0,0,0,0,0,0,
            0,0,0,0,0,0,
            0,0,0,0,0,0,
            0,0,0,0,0,0
        ];
        var turn = "R";
        var clickable = true;

        this.channel.on("echo", msg => {
            console.log(msg);
            if(msg["game_state"] == "win") {
                clickable = false;
                if(msg["turn"] == "R") {
                    document.getElementById("Rwins").style.display = "block";
                } else {
                    document.getElementById("Bwins").style.display = "block";
                }
            }
        });
        

        document.body.addEventListener("click", ev => {
            // console.log(ev.target.id);
            var targ = ev.target.id;
            if(arr.includes(targ) && clickable) {
                var intColumn = arr.indexOf(targ);
                var newArr = [(6*3)+intColumn, (6*2)+intColumn, (6*1)+intColumn, (6*0)+intColumn];
                // console.log(newArr);
                var newSpot;
                var full = false;
                if(board[newArr[0]] == 0){
                    newSpot = newArr[0];
                } else if(board[newArr[1]] == 0) {
                    newSpot = newArr[1];
                } else if(board[newArr[2]] == 0) {
                    newSpot = newArr[2];
                } else if(board[newArr[3]] == 0) {
                    newSpot = newArr[3];
                } else {
                    full = true;
                }
                if(turn == "R" && !full) {
                    board[newSpot] = "R";
                    // console.log(board);
                    document.getElementById(newSpot.toString()).style.backgroundColor = "red";
                    // block.target.style.backgroundColor = "red";
                    
                    this.channel.push("turn_played", {board: board, turn: turn});
                    turn = "B";
                } else if(!full && turn == "B") {
                    board[newSpot] = "B";
                    // console.log(board);
                    document.getElementById(newSpot.toString()).style.backgroundColor = "black";
                    // block.style.backgroundColor = "blue";
                    
                    this.channel.push("turn_played", {board: board, turn: turn});
                    turn = "R";
                } else {
                    console.log("col is full")
                }
                
                
            }

            

        })
    }

    



}