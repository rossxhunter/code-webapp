// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('#new_code_lesson_button').click(function(e) {
  e.preventDefault();

  $('#new_code_lesson_modal').modal();
});

$(window).on('load', function() {
  if ( $('#new_code_lesson_modal').attr('data-show-on-load') == 'true' ) {
    $('#new_code_lesson_modal').modal();
  }
});
