$(document).ready(function(){
  $('[data-toggle="popover"]').popover();
});

$('body').on('click', '.dashboard-list-group-item.-course', function(e) {
  var currently_selected = $(this).hasClass('-selected');

  $(this).parent().children('.dashboard-list-group-item.-course').each(function() {
    $(this).removeClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-course').slideUp();
  });

  if (!currently_selected) {
    $(this).addClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-course').slideDown();
  }

  var course_id = $(this).attr('data-course-id');

  $.ajax({
    type: 'POST',
    url: '/dashboard/get-tracks',
    data: {
      course_id: course_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);

    $('.dashboard-list-group.-tracks').empty();
    $('.dashboard-list-group.-code-lessons').empty();
    $('.dashboard-list-group.-students').empty();

    for (var i = 0; i < parsed_data.tracks.length; i++) {
      var track = parsed_data.tracks[i];
      var track_html = '<li class="list-group-item dashboard-list-group-item -track" data-track-id="' + track.id + '">' + track.name +'</li>\
      <li class="list-group-item dashboard-list-group-item-info -track" style="display: none;"><div class="btn-group btn-group-sm"><a href="/insights/track/' + track.id +'" class="btn btn-secondary">Insights</a></div></li>';
      $('.dashboard-list-group.-tracks').append($(track_html));
    }

    var display_tracks_html = '<li class="list-group-item dashboard-list-group-item"><a href="' + parsed_data.display_tracks_link +'">Manage tracks</a></li>';
    $('.dashboard-list-group.-tracks').append($(display_tracks_html));
  });
});

$('body').on('click', '.dashboard-list-group-item.-track', function(e) {
  var currently_selected = $(this).hasClass('-selected');

  $(this).parent().children('.dashboard-list-group-item.-track').each(function() {
    $(this).removeClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-track').slideUp();
  });

  if (!currently_selected) {
    $(this).addClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-track').slideDown();
  }

  var track_id = $(this).attr('data-track-id');

  $.ajax({
    type: 'POST',
    url: '/dashboard/get-code-lessons',
    data: {
      track_id: track_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);

    $('.dashboard-list-group.-code-lessons').empty();
    $('.dashboard-list-group.-students').empty();

    for (var i = 0; i < parsed_data.code_lessons.length; i++) {
      var lesson = parsed_data.code_lessons[i];
      var lesson_html = '<li class="list-group-item dashboard-list-group-item -code-lesson" data-code-lesson-id="' + lesson.id + '">' + lesson.name +'</li>\
      <li class="list-group-item dashboard-list-group-item-info -code-lesson" style="display: none;"><div class="btn-group btn-group-sm"><a href="/code-lessons/' + lesson.id + '" class="btn btn-primary">View</a>\
      <a href="/insights/code_lesson/' + lesson.id + '" class="btn btn-secondary">Insights</a></div></li>';
      $('.dashboard-list-group.-code-lessons').append($(lesson_html));
    }

    var display_lessons_html = '<li class="list-group-item dashboard-list-group-item"><a href="' + parsed_data.display_lessons_link +'">Manage lessons</a></li>';
    $('.dashboard-list-group.-code-lessons').append($(display_lessons_html));
  });
});

$('body').on('click', '.dashboard-list-group-item.-code-lesson', function(e) {
  var currently_selected = $(this).hasClass('-selected');

  $(this).parent().children('.dashboard-list-group-item.-code-lesson').each(function() {
    $(this).removeClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-code-lesson').slideUp();
  });

  if (!currently_selected) {
    $(this).addClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-code-lesson').slideDown();
  }

  var code_lesson_id = $(this).attr('data-code-lesson-id');
  $.ajax({
    type: 'POST',
    url: '/dashboard/get-students',
    data: {
      code_lesson_id: code_lesson_id
    }
  }).done(function(data) {
    var parsed_data = JSON.parse(data);
    $('.dashboard-list-group.-students').empty();

    for (var i = 0; i < parsed_data.students.length; i++) {
      var student = parsed_data.students[i];
      var student_name = student.first_name + ' ' + student.last_name;
      var result = parsed_data.results[i];
      var used_hint = parsed_data.hint_used[i];
      var yesNo = '';
      if (used_hint) {
        yesNo = 'Yes';
      } else {
        yesNo = 'No';
      }
      var num_subs = parsed_data.num_of_subs[i];
      var student_html = '';

      if (result == null) {
        student_html = '<li class="list-group-item dashboard-list-group-item -student" data-student-id="' + student.id + '"><i class="fas fa-ellipsis-h"></i> ' + student_name  + '</li>';
        student_html = student_html +'<li class="list-group-item dashboard-list-group-item-info -student" style="display: none;"><div class="btn-group btn-group-sm" role="group">\
        <a class="btn btn-sm float-sm-left btn-secondary" href="/insights/student/' + student.id + '">Insights</a>\
        <a class="btn btn-sm float-sm-left btn-secondary" href="/students/' + student.id + '">View</a></div></li>';
      } else if (result) {
        student_html ='<li class="list-group-item dashboard-list-group-item -student" data-student-id="' + student.id +'"><i class="fas fa-check"></i> ' + student_name +
          '<button type="button" class="btn btn-info btn-sm float-sm-right" data-toggle="popover" data-trigger="focus" data-placement="right" title="Submissions & Hints" data-content="Number of submissions: ' +
          num_subs + '</br>Hint used: ' + yesNo + '" data-html="true">Info</button></li>';
          student_html = student_html +'<li class="list-group-item dashboard-list-group-item-info -student" style="display: none;"><div class="btn-group btn-group-sm" role="group">\
          <a class="btn btn-sm float-sm-left btn-secondary" href="/insights/student/' + student.id + '">Insights</a>\
          <a href="/code-lessons/'+ code_lesson_id + '/submissions/' + student.id + '" class="btn btn-sm float-sm-right btn-success">Submissions</a>\
          <a class="btn btn-sm float-sm-left btn-secondary" href="/students/' + student.id + '">View</a></div></li>';
      } else {
        student_html ='<li class="list-group-item dashboard-list-group-item -student" data-student-id="' + student.id +'"><i class="fas fa-times"></i> ' + student_name +
          '<button type="button" class="btn btn-info btn-sm float-sm-right" data-toggle="popover" data-trigger="focus" data-placement="right" title="Submissions & Hints" data-content="Number of submissions: ' +
          num_subs + '</br>Hint used: ' + yesNo + '" data-html="true">Info</button></li>';
          student_html = student_html +'<li class="list-group-item dashboard-list-group-item-info -student" style="display: none;"><div class="btn-group btn-group-sm" role="group">\
          <a class="btn btn-sm float-sm-left btn-secondary" href="/insights/student/' + student.id + '">Insights</a>\
          <a href="/code-lessons/'+ code_lesson_id + '/submissions/' + student.id + '" class="btn btn-sm float-sm-right btn-success">Submissions</a>\
          <a class="btn btn-sm float-sm-left btn-secondary" href="/students/' + student.id + '">View</a>\
          </div></li>';
      }

      $('.dashboard-list-group.-students').append($(student_html));
    }
    $(document).ready(function(){
        $('[data-toggle="popover"]').popover();
    });
  });
});

$('body').on('click', '.dashboard-list-group-item.-student', function(e) {
  var currently_selected = $(this).hasClass('-selected');

  $(this).parent().children('.dashboard-list-group-item.-student').each(function() {
    $(this).removeClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-student').slideUp();
  });

  if (!currently_selected) {
    $(this).addClass('-selected');
    $(this).next('.dashboard-list-group-item-info.-student').slideDown();
  }

  var code_lesson_id = $(this).attr('data-student-id');
});

$('body').on('click', '.student-dashboard-list-group-item.-track', function(e) {
  var currently_selected = $(this).hasClass('-selected');

  $(this).parent().children('.student-dashboard-list-group-item.-track').each(function() {
    $(this).removeClass('-selected');
    $(this).next('.student-dashboard-list-group-item-info.-track').slideUp();
  });
  if (!currently_selected) {
    $(this).addClass('-selected');
    $(this).next('.student-dashboard-list-group-item-info.-track').slideDown();
  }
});
