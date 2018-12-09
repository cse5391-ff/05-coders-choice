import "phoenix_html"

class Notes {

    /*
        Attributes

        notes         = {'c': {'audio': <Audio>, 'pressed': <bool>} ...}
        min_ring_time = 500 ms (minimum time for full note to be heard)
    */

    constructor(path='piano_notes/') {

        // Initialize class attributes
        this.min_ring_time = 300;
        this.notes = {}

        // Build out notes
        let note_letters = ['c', 'cs', 'd', 'ds', 'e', 'f', 'fs', 'g', 'gs', 'a', 'as', 'b']
        for(let octave = 1; octave <= 2; octave++) {

            for(let i in note_letters) {

                let n = `${note_letters[i]}-${octave}`
                
                this.notes[n] = {}

                this.notes[n].audio      = new Audio()
                this.notes[n].audio.src  = `${path}${n}.mp3`
                this.notes[n].pressed    = false
                this.notes[n].last_press = null

            }

        }

        this.notes['c-3'] = {}

        this.notes['c-3'].audio      = new Audio()
        this.notes['c-3'].audio.src  = `${path}c-3.mp3`
        this.notes['c-3'].pressed    = false
        this.notes['c-3'].last_press = null

    }

    press(note){
        this.notes[note].pressed    = true
        this.notes[note].last_press = new Date().getTime()

        this.notes[note].audio.pause()
        this.notes[note].audio.currentTime = 0
        this.notes[note].audio.play()
    }

    release(note){

        this.notes[note].pressed = false
        let time_to_wait = this.min_ring_time - this.notes[note].audio.currentTime * 1000
    
        // I am ashamed of this... (or do I mean that??)
        let that = this
        setTimeout(function(){
            that.stop(note)
        }, time_to_wait)

    }

    stop(note){

        let time_since_last = new Date().getTime() - this.notes[note].last_press

        if(!this.notes[note].pressed && (time_since_last >= this.min_ring_time)) {
            this.notes[note].audio.pause()
            this.notes[note].audio.currentTime = 0
        }

    }

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
            piano_html += `<div id="${notes.white[k]}-${octave}" class="white-key"></div>`
        }

        for(let k in notes.black) {
            piano_html += `<div id="${notes.black[k]}-${octave}" class="black-key"></div>`
        }

    }

    // Add final note
    piano_html += `<div id="c-3" class="white-key"></div>`

    document.getElementById('piano-container').innerHTML = piano_html
}

// BEGIN EXECUTION
build_piano(notes)

var notes = new Notes()

function press_note(note){
    notes.press(note)
}

function release_note(note){
    notes.release(note)
}

function attach_event_listeners(){

    let key_divs = document.getElementById('piano-container').children
    for(let i in key_divs){

        key_divs[i].addEventListener(
            "mousedown", 
            function(){
                press_note(key_divs[i].id)
                key_divs[i].style.background = "grey"
            }, 
            false
        )

        key_divs[i].addEventListener(
            "mouseup", 
            function(){
                release_note(key_divs[i].id)
                key_divs[i].style.background = "white"
            }, 
            false
        )

    }
}

attach_event_listeners()