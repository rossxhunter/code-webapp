$(document).ready(function() {
  $('#new_live_coding_session').on("ajax:success", function(e, data, status, xhr) {
    $('#live_coding_modal').modal('toggle');
    $('#live_coding_session_button').hide();
    $('#live_coding_session_requested').show();
  });
});
