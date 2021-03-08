$(document).ready(function() {
  if ($('#student_table').length > 0) {
    $('#student_table').DataTable();
  }
});

$(document).ready(function() {
  if ($('#student_leaderboard').length > 0) {
    $('#student_leaderboard').DataTable({
      "order" : [[1, "desc"]]
    });
  }
});


function displayNotification(message) {
  $('.notification-alert').fadeIn();
  $('.notification-alert .alert-message').html(message);

  setTimeout(function() {
    $('.notification-alert').fadeOut();
  }, 5000);
}

var last_assignment_id;
var first_time = true;

function checkForAssignments() {
  var current_student_id = $('body').attr('data-current-student-id');

  if ( current_student_id != 'false' && current_student_id != undefined ) {
    $.ajax({
      type: 'GET',
      url: '/students/' + current_student_id + '/get-assignments'
    }).done(function(parsed_data) {
      if ( parsed_data.assignments.length > 0 ) {
        var last_assignment = parsed_data.assignments[parsed_data.assignments.length - 1];

        if ( !first_time && last_assignment.id != last_assignment_id ) {
          displayNotification(parsed_data.notification_message);
        }

        last_assignment_id = last_assignment.id;
      }

      first_time = false;

      setTimeout(checkForAssignments, 2000);
    });
  }
}

checkForAssignments();
