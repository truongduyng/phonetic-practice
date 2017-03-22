$(document).ready(function() {
  get_question();

  $('#refresh_question').click(function(e) {
    e.preventDefault();
    get_question();
  });

  $('form#new_check').on('ajax:beforeSend', function(event, xhr, settings) {
    $('#checking_loading').css('display', 'block');
    $('#result, #right_ans').html('');
  });

  $('form#new_check').on('ajax:complete', function(event, xhr, settings) {
    $('#checking_loading').css('display', 'none');
  });
})

function get_question() {
  $.ajax({
    url: "/questions/qoute_question",
    method: 'GET',
    dataType: 'json',
    beforeSend: function() {
      $('#refresh_question i').addClass('fa-spin');
    }
  }).done(function(msg) {
    $('p.question').html(msg.question);
    $('#check_question').val(msg.question);
    $('#refresh_question i').removeClass('fa-spin');
  });

}
