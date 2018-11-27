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
                document.getElementById("restart").style.display = "block";
                if(msg["turn"] == "R") {
                    document.getElementById("Rwins").style.display = "block";
                    document.getElementById("Rturn").style.display = "none";
                    alert("RED WINS!!!");
                } else {
                    document.getElementById("Bwins").style.display = "block";
                    document.getElementById("Bturn").style.display = "none";
                    alert("BLACK WINS!!!");
                }
            }

            if(msg["game_state"] == "tie") {
                clickable = false;
                document.getElementById("restart").style.display = "block";
                document.getElementById("Rturn").style.display = "none"; 
                document.getElementById("Bturn").style.display = "none";
                document.getElementById("tie").style.display = "block";
                alert("TIE GAME");
            }

            if(msg["turn"] == "R" && msg["game_state"] != "win" && msg["game_state"] != "init" && msg["game_state"] != "tie") {
                document.getElementById("Bturn").style.display = "block";
                document.getElementById("Rturn").style.display = "none";
            } else if(msg["turn"] == "B" && msg["game_state"] != "win" && msg["game_state"] != "init" && msg["game_state"] != "tie") {
                document.getElementById("Rturn").style.display = "block";
                document.getElementById("Bturn").style.display = "none";
            }

            for(var x = 0; x < msg["board"].length; x++){
                if(msg["board"][x] != 0) {
                    if(msg["board"][x] == "R"){
                        document.getElementById(x.toString()).style.backgroundColor = "red";
                    } else {
                        document.getElementById(x.toString()).style.backgroundColor = "black";
                    }
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
                    var diag = this.setupDiagnol(board);
                    this.channel.push("turn_played", {board: board, turn: turn, diag: diag});
                    turn = "B";
                } else if(!full && turn == "B") {
                    board[newSpot] = "B";
                    // console.log(board);
                    document.getElementById(newSpot.toString()).style.backgroundColor = "black";
                    // block.style.backgroundColor = "blue";
                    var diag = this.setupDiagnol(board);
                    this.channel.push("turn_played", {board: board, turn: turn, diag: diag});
                    turn = "R";
                } else {
                    console.log("col is full")
                }
                
                
            }

            

        })

        document.getElementById("restart").addEventListener("click", ev=>{
            // alert("Restarted");
            board = [
                0,0,0,0,0,0,
                0,0,0,0,0,0,
                0,0,0,0,0,0,
                0,0,0,0,0,0
            ];
            turn = "R";
            for(var x = 0; x < board.length; x++){
                document.getElementById(x.toString()).style.backgroundColor = "white";
                   
            }
            
            document.getElementById("Bwins").style.display = "none";
            document.getElementById("Rwins").style.display = "none"; 
            document.getElementById("tie").style.display = "none";
            document.getElementById("restart").style.display = "none";

            this.channel.push("new_game");
            clickable = true;
            document.getElementById("Bturn").style.display = "none";
            document.getElementById("Rturn").style.display = "block";
        });
    }

    setupDiagnol(board) {
        var diags = [];
        var d1 = [];
        var d2 = [];
        var d3 = [];
        var d4 = [];
        var d5 = [];
        var d6 = [];
        for(var i = 0; i < board.length; i++) {
            if(i == 3 | i == 8 | i == 13 |i == 18 ) {
                d1.push(board[i]);
            }
            if(i == 4 | i == 9 |i == 14 |i == 19 ) {
                d2.push(board[i]);
            }
            if(i == 5 | i == 10 |i == 15 | i == 20 ) {
                d3.push(board[i]);
            }
            if(i == 0 | i == 7 |i == 14 |i == 21 ) {
                d4.push(board[i]);
            }
            if(i == 1 |i == 8 |i == 15 |i == 22 ) {
                d5.push(board[i]);
            }
            if(i == 2 |i == 9 |i == 16 |i == 23 ) {
                d6.push(board[i]);
            }
        }
        diags.push(d1);
        diags.push(d2);
        diags.push(d3);
        diags.push(d4);
        diags.push(d5);
        diags.push(d6);
        // console.log(diags);
        return diags;

    }

    



}