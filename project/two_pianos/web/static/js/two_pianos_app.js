import TwoPianosSocket from "./two_pianos_socket.js"

window.onload = function () {
  let two_pianos = new TwoPianosSocket()
  two_pianos.connect_to_two_pianos()
}