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
 let channel;
 let list = $('#message-list');
 let message = $('#msg');
 let username = $('#username');
 let urgency = $('#urgency');
 let channel_list = $('#channel-list');
 let modal = $('#modal');
 let span = $('.close')[0];
 join_channel(chatroom)

 function join_channel(chatroom) {
    channel = socket.channel(`chat_room:${chatroom}`, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) });

    update_listeners()
 }

 message.on('keypress', event => {
    var urgency = "normal";
    if($('#urgent').is(':checked')){
        urgency = "urgent";
    }
    else if($('#peripheral').is(':checked')){
        urgency = "peripheral";
    }
    if (event.keyCode == 13) {
         channel.push('shout', {
            username: username.val(),
            message: message.val(),
            urgency: urgency,
            chatroom: chatroom,
         });
         message.val('');
     }
 })

$('#add_new').on('click', function(){
    // trigger dialogue box
    modal.show();
    span.onclick = function() {
        modal.hide();
    }
    window.onclick = function(event) {
        if (event.target == modal) {
          modal.hide();
        }
    }

    $('#new_submit').on('click', function(){
        clear_msg_list();
        clear_unread_badges();
        chatroom = $('chat_name').val;
        // join channel
      join_channel(chatroom);
    })

    }
)

//  trigger channel switch
channel_list.on('click', 'li', function(){
    clear_msg_list();
    clear_unread_badges();
    chatroom = $(this).attr('id');
    join_channel(chatroom);
})

// do not update list_channels because it only needs to be called once
channel.on('list_channels', payload => {
    channel_list.append(`<li id="${payload.channel}">${payload.channel}</li>`);
 })

// listeners must be updated because channel is listening to a new topic
function update_listeners(){
    channel.on('shout', payload => {
        var prepend;
        if(payload.urgency=="urgent") {
            prepend = "!";
        }
        else if(payload.urgency=="peripheral") {
            prepend = "*";
        }
        else {
            prepend = "";
        }

        list.append(`<div class="msg col-md-12">${prepend} <b>${payload.username || 'new_user'}:</b> ${payload.message}</div>`);
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
     channel.on('read_channel', payload => {
        $(`#${payload.channel}`).append(`<span class="badge">${payload.unread}</span>`)
     }
    )
}

function clear_msg_list() {
    list.html("");
}

function clear_unread_badges() {
    $('.badge').html("");
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