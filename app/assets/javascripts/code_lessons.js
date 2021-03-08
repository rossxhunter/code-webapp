$(document).ready(function() {
  $('#new_chat_message').on('ajax:success', function(e) {
    $('#chat_message_message').val('');
  });
});

function publishLiveCodeSessionData(code, cursor_pos) {
  var session_id = $('body').attr('data-live-coding-session-id');

  if ( typeof session_id !== typeof undefined && session_id !== false ) {
    $.ajax({
      type: 'POST',
      url: '/live-coding-sessions/' + session_id + '/publish-code',
      data: {
        code: code,
        cursor_pos: cursor_pos
      }
    });
  }
}
