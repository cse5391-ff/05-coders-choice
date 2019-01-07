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

 import socket from "./socket"

//  Initial chat setup sourced from 
 let chatroom = "lobby";
 let channel = socket.channel(`chat_room:${chatroom}`, {});
 let list = $('#message-list');
 let message = $('#msg');
 let username = $('#username');
 let urgency = $('#urgency');
 let channel_list = $('#channel-list');

 channel
 .join()
 .receive('ok', resp => {
     console.log('Joined successfully', resp);
 })
 .receive('error', resp => {
     console.log('Unable to join', resp);
 });

 update_listeners();

 message.on('keypress', event => {
     if (event.keyCode == 13) {
         channel.push('shout', {
            username: username.val(),
            message: message.val(),
            urgency: urgency.val(),
            chatroom: chatroom,
         });
         message.val('');
     }
 })

//  trigger channel switch
channel_list.on('click', 'li', function(){
    clear_msg_list();
    chatroom = $(this).html();
    channel = socket.channel(`chat_room:${chatroom}`, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) });

    update_listeners()
})

// do not update list_channels because it only needs to be called once
channel.on('list_channels', payload => {
    channel_list.append(`<li id="${payload.channel}">${payload.channel}</li>`);
 })

//listeners must be updated because channel is listening to a new topic
function update_listeners(){
    channel.on('shout', payload => {
        list.append(`<div class="msg col-md-12"><b>${payload.username || 'new_user'}:</b> ${payload.message}</div>`);
        list.prop({
            scrollTop: list.prop('scrollHeight')
        })
    })
    
    channel.on('update_active_navbar', payload => {
        // remove all active classes
        $('.active').removeClass('active');
        $(`#${payload.active}`).addClass('active');
     })

     // update labels for all channels
     channel.on('read_channels', payload => {
         console.log("hello");
        $(`#${payload.channel}`).add(`<span class="badge">${payload.count}</span>`)
     })
}

function clear_msg_list() {
    list.html("");
}

$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });
});

$("input:checkbox").on('click', function() {
    // in the handler, 'this' refers to the box clicked on
    var $box = $(this);
    if ($box.is(":checked")) {
      // the name of the box is retrieved using the .attr() method
      // as it is assumed and expected to be immutable
      var group = "input:checkbox[name='" + $box.attr("name") + "']";
      // the checked state of the group/box on the other hand will change
      // and the current value is retrieved using .prop() method
      $(group).prop("checked", false);
      $box.prop("checked", true);
    } else {
      $box.prop("checked", false);
    }
  });