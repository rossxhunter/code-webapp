App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    return $('.chat-messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    var user_type = $('body').attr('data-current-user-type');

    if (data.type == 'Student') {
      if (user_type == 'Student') {
        return '<li class="media chat-message">\
          <div class="media-body"><h6>' + data.user_name + '</h6>' + data.message + '</div>' + data.image + '\
        </li>';
      } else if (user_type == 'Teacher') {
        return '<li class="media chat-message">\
          ' + data.image + '\
          <div class="media-body"><h6>' + data.user_name + '</h6>' + data.message + '</div>\
        </li>';
      }
    }

    if (data.type == 'Teacher') {
      if (user_type == 'Teacher') {
        return '<li class="media chat-message">\
          <div class="media-body"><h6>' + data.user_name + '</h6>' + data.message + '</div>' + data.image + '\
        </li>';
      } else {
        return '<li class="media chat-message">\
          ' + data.image + '\
          <div class="media-body"><h6>' + data.user_name + '</h6>' + data.message + '</div>\
        </li>';
      }
    }
  }
});
