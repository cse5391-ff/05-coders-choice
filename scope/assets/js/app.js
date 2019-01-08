import "phoenix_html"
import socket from "./socket"

//  Initial chat setup
//  Source: https://github.com/tensor-programming/phoenix_1.3_chat_app

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

// add new channel not fully operational, 
// would recommend using currently in use channels
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

// keeps only one of the urgency checkboxes checked
// Source: https://stackoverflow.com/questions/9709209/html-select-only-one-checkbox-in-a-group
$("input:checkbox").on('click', function() {
    var $box = $(this);
    if ($box.is(":checked")) {
      var group = "input:checkbox[name='" + $box.attr("name") + "']";
      $(group).prop("checked", false);
      $box.prop("checked", true);
    } else {
      $box.prop("checked", false);
    }
  });