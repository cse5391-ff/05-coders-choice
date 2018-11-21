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
        var turn = 0;

        

        document.body.addEventListener("click", ev => {
            // console.log(ev.target.id);
            var targ = ev.target.id;
            if(arr.includes(targ)) {
                var intColumn = arr.indexOf(targ);
                var newArr = [(6*3)+intColumn, (6*2)+intColumn, (6*1)+intColumn, (6*0)+intColumn];
                console.log(newArr);
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
                if(turn == 0 && !full) {
                    board[newSpot] = 1;
                    console.log(board);
                    document.getElementById(newSpot.toString()).style.backgroundColor = "red";
                    // block.target.style.backgroundColor = "red";
                    
                    this.channel.push("turn_played", {board: board, turn: turn});
                    turn = 1;
                } else if(!full && turn == 1) {
                    board[newSpot] = 1;
                    console.log(board);
                    document.getElementById(newSpot.toString()).style.backgroundColor = "black";
                    // block.style.backgroundColor = "blue";
                    
                    this.channel.push("turn_played", {board: board, turn: turn});
                    turn = 1;
                } else {
                    console.log("col is full")
                }
                
                
            }

            

        })
    }

    



}