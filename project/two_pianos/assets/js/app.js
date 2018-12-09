import "phoenix_html"

class Notes {

    constructor(path='piano_notes/') {

        let notes = ['c', 'cs', 'd', 'ds', 'e', 'f', 'fs', 'g', 'gs', 'a', 'as', 'b']

        this.audio = {}
        for(let octave = 1; octave <= 2; octave++) {

            for(let i in notes) {

                let n = `${notes[i]}-${octave}`

                this.audio[n]     = new Audio()
                this.audio[n].src = `${path}${n}.mp3`

            }

        }

        this.audio['c-3']     = new Audio()
        this.audio['c-3'].src = `${path}c-3.mp3`

        console.log('sup chris')
    }

    play(note){
        this.audio[note].play()
    }

}

var notes = new Notes()

function play_note(note){
    notes.play(note)
}

function build_piano() {

    let piano_html = ''

    let notes = {
        white: ['c', 'd', 'e', 'f', 'g', 'a', 'b'],
        black: ['cs', 'ds', 'fs', 'gs', 'as']
    }

    let octaves = 2

    for(let octave = 1; octave <= octaves; octave++) {

        for(let k in notes.white) {
            piano_html += `<div id="note-${notes.white[k]}-${octave}" class="white-key"></div>`
        }

        for(let k in notes.black) {
            piano_html += `<div id="note-${notes.black[k]}-${octave}" class="black-key"></div>`
        }

    }

    // Add final note
    piano_html += `<div id="note-c-3" class="white-key"></div>`

    document.getElementById('piano-container').innerHTML = piano_html
}

build_piano()

document.getElementById('note-c-1').addEventListener("click", function(){notes.play('c-1')}, false)
document.getElementById('note-cs-1').addEventListener("click", function(){notes.play('cs-1')}, false)
document.getElementById('note-d-1').addEventListener("click", function(){notes.play('d-1')}, false)
document.getElementById('note-ds-1').addEventListener("click", function(){notes.play('ds-1')}, false)
document.getElementById('note-e-1').addEventListener("click", function(){notes.play('e-1')}, false)
document.getElementById('note-f-1').addEventListener("click", function(){notes.play('f-1')}, false)
document.getElementById('note-fs-1').addEventListener("click", function(){notes.play('fs-1')}, false)
document.getElementById('note-g-1').addEventListener("click", function(){notes.play('g-1')}, false)
document.getElementById('note-gs-1').addEventListener("click", function(){notes.play('gs-1')}, false)
document.getElementById('note-a-1').addEventListener("click", function(){notes.play('a-1')}, false)
document.getElementById('note-as-1').addEventListener("click", function(){notes.play('as-1')}, false)
document.getElementById('note-b-1').addEventListener("click", function(){notes.play('b-1')}, false)

document.getElementById('note-c-2').addEventListener("click", function(){notes.play('c-2')}, false)
document.getElementById('note-cs-2').addEventListener("click", function(){notes.play('cs-2')}, false)
document.getElementById('note-d-2').addEventListener("click", function(){notes.play('d-2')}, false)
document.getElementById('note-ds-2').addEventListener("click", function(){notes.play('ds-2')}, false)
document.getElementById('note-e-2').addEventListener("click", function(){notes.play('e-2')}, false)
document.getElementById('note-f-2').addEventListener("click", function(){notes.play('f-2')}, false)
document.getElementById('note-fs-2').addEventListener("click", function(){notes.play('fs-2')}, false)
document.getElementById('note-g-2').addEventListener("click", function(){notes.play('g-2')}, false)
document.getElementById('note-gs-2').addEventListener("click", function(){notes.play('gs-2')}, false)
document.getElementById('note-a-2').addEventListener("click", function(){notes.play('a-2')}, false)
document.getElementById('note-as-2').addEventListener("click", function(){notes.play('as-2')}, false)
document.getElementById('note-b-2').addEventListener("click", function(){notes.play('b-2')}, false)

document.getElementById('note-c-3').addEventListener("click", function(){notes.play('c-3')}, false)
