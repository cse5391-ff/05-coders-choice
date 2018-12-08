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

function build_piano(octaves) {

    let piano_html = ''

    let notes = {
        white: ['c', 'd', 'e', 'f', 'g', 'a', 'b'],
        black: ['cs', 'ds', 'fs', 'gs', 'as']
    }

    for(let octave = 1; octave <= octaves; octave++){

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

build_piano(2)