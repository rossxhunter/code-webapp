$('.open-target-modal').click(function(e) {
  e.preventDefault();

  var target = $(this).attr('data-target');
  $('#' + target).modal();
});

$(function() {
  $('[data-toggle="tooltip"]').tooltip();
});
