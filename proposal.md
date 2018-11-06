Name: Chris Ragsdale   ID: 43584103

## Proposed Project

I will make a piano-teaching webapp that provides an on-screen piano for both student and teacher. Both pianos will be keyboard-controlled,will sound for both members of the room, and will have visual feedback so that both members can more easily follow what the other is doing. To build on this further, there will be a built-in UI chord and scale library that highlights relevant keys for said chords/scales, and a personal scale/chord builder.

## Outline Structure

The application will supervise rooms, which will supervise people (socket connections) and their keyboards. Keyboards will supervise individual keys. 

I will use the Phoenix Framework as my web framework, and the WebAudioAPI client-side to handle producing sound from the browser.