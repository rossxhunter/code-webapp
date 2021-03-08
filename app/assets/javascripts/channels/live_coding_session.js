var live_coding_session_id = $('body').attr('data-live-coding-session-id');

App.live_coding_session = App.cable.subscriptions.create({ channel: "LiveCodingSessionChannel", live_coding_session_id: live_coding_session_id }, {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if ( $('body').attr('data-current-user-type') == 'Teacher' ) {
      editor.setValue(data.code, -1);
      editor.moveCursorTo(data.cursor_pos.row + 1, data.cursor_pos.column)
    }
  }
});
