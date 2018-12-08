// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function build_piano() {

    let piano_html = ''

    let notes = {
        white: ['c', 'd', 'e', 'f', 'g', 'a', 'b'],
        black: ['cs', 'ds', 'fs', 'gs', 'as']
    }

    let octaves = 2

    for(let octave = 1; octave <= octaves; octave++) {

        // White keys
        for(let k in notes.white) {
            piano_html += `<div id="note-${notes.white[k]}-${octave}" class="white-key"></div>`
        }

        // Black keys
        for(let k in notes.black) {
            piano_html += `<div id="note-${notes.black[k]}-${octave}" class="black-key"></div>`
        }

    }

    // Add final note
    piano_html += '<div id="note-c-3" class="white-key"></div>'

    document.getElementById('piano-container').innerHTML = piano_html
}

function init_audio() {

    let path = 'piano_notes/'
    let notes = ['c', 'cs', 'd', 'ds', 'e', 'f', 'fs', 'g', 'gs', 'a', 'as', 'b']

    let notes_audio = {}
    for(let octave = 1; octave <= 2; octave++) {

        for(let i in notes) {

            let n = `${notes[i]}-${octave}`

            notes_audio[n]     = new Audio()
            notes_audio[n].src = `${path}${n}.mp3`

        }

    }

    notes_audio['c-3']     = new Audio()
    notes_audio['c-3'].src = `${path}c-3.mp3`

    return notes_audio

}

build_piano()
let notes_audio = init_audio()

let play_random = function(notes_audio) {
    notes_audio['c-3'].play()
}