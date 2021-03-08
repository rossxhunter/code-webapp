var hint_showing = false;
$(document).ready(function(){
  editor.setReadOnly(false);
  var lesson_id = $("#editor").attr('data-lesson-id');
  TimeMe.initialize({
    currentPageName: "code-lesson-" + lesson_id, // current page
    idleTimeoutInSeconds: 30 // seconds
  });
  TimeMe.startTimer("code-lesson-" + lesson_id);
});

$('#code-lesson-tabs a.nav-link').click(function(e) {
  var $this = $(this);
  if ( $this.attr('aria-controls') == 'lesson-code-editor' ) {
    $('.container.form').show();
    $('.container.correctness-test-helper').hide();
  } else {
    $('.container.form').hide();
    $('.container.correctness-test-helper').show();
  }
});
$('#code-lesson-submit-code').click(function(e) {
  e.preventDefault();

  var $this = $(this);
  var code_lesson_id = $this.attr('data-code-lesson-id');
  var nameOfActivity = "code-lesson-" + code_lesson_id;
  TimeMe.stopTimer(nameOfActivity);
  var timeTaken = Math.floor(TimeMe.getTimeOnPageInSeconds(nameOfActivity));
  TimeMe.resetRecordedPageTime(nameOfActivity);
  // restart timer at end of 'done' section
  $.ajax({
    type: 'POST',
    url: '/code-lessons/' + code_lesson_id + '/run-code',
    data: {
      user_code: editor.getValue(),
      student_id: $this.attr('data-student-id'),
      time_taken: timeTaken
    }
  }).done(function(parsed_data) {
    jqconsole.Write(parsed_data.output, "jqconsole-output");

    if (parsed_data.success) {
      $('#code_lesson_next_container').show();
      $('#failure-message-icon-container').hide();

      $('.success-message-fade').fadeIn();
      setTimeout(function(){
        $('.success-message-fade').fadeOut();
      }, 4000);
    } else {
      $('#success-message-icon-container').hide();

      $('.failure-message-fade').fadeIn();
      setTimeout(function() {
        $('.failure-message-fade').fadeOut();
      }, 4000);
    }

    if ( !hint_showing && parsed_data.display_hint ) {
      $('#code-lesson-submit-code').addClass('shrink');

      setTimeout(function() {
        $('.code-lesson-hint').addClass('display');
      }, 165);

      hint_showing = true;
    }
  }).fail(function(xhr, error, status) {
    jqconsole.Write("Error 500: Internal Server Error\n", "jqconsole-error");
  });
  TimeMe.startTimer("code-lesson-" + code_lesson_id);
});

$('.code-lesson-hint').click(function(e) {
  var $this = $(this);

  $.ajax({
    type: 'POST',
    url: '/code-lessons/' + $this.attr('data-code-lesson-id') + '/get-hint'
  }).done(function(parsed_data) {
    if (parsed_data.success) {
      $('#collapse_hint').collapse();
      $('#collapse_hint .card-body').html(parsed_data.hint);
      $this.html($this.attr('data-original-text'));
    }
  }).fail(function(xhr, error, status) {

  });
});

$('.code-lesson-reset').click(function(e) {

  var $this = $(this);
  var code_lesson_id = $this.attr('data-code-lesson-id');

  $.ajax({
    type: 'POST',
    url: '/code-lessons/' + code_lesson_id + '/get-starting-code'
  }).done(function(data) {
    var parsed_data = JSON.parse(data);
    var starting_code = parsed_data.starting_code;
    // clear and set editor
    editor.setValue(starting_code, 0);
  });
});

$('.code-lesson-next').click(function(e) {

  var $this = $(this);
  var code_lesson_id = $this.attr('data-code-lesson-id');

  $.ajax({
    type: 'POST',
    url: '/code-lessons/' + code_lesson_id + '/get-next-lesson'
  }).done(function(data) {
    var parsed_data = JSON.parse(data);
    var next_lesson = parsed_data.next_lesson;
    // clear and set editor
    if (next_lesson == null) {
      $(location).attr('href', '/student-dashboard/')

    } else {
      $(location).attr('href', '/code-lessons/' + next_lesson.id)
    }
  });
});
