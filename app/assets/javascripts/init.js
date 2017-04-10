document.addEventListener("turbolinks:load", function() {
  get_question();

  $('#refresh_question').click(function(e) {
    e.preventDefault();
    get_question();
  });

  $('form#new_check').on('ajax:beforeSend', function(event, xhr, settings) {
    $('.checking_loading').css('display', 'block');
    $('#result, #right_ans').html('');
  });

  $('form#new_check').on('ajax:complete', function(event, xhr, settings) {
    $('.checking_loading').css('display', 'none');
  });

  $('#check_answer').on('change input paste', function() {
    ans = $('#check_answer').val();
    $('#check_answer').val(standardized_ans(ans));
  })
})

function standardized_ans(ans) {
  ipa_list = ["ˈ", ",", "ɑː", "aɪ", "aʊ", "ɔː", "ɔɪ", "ʊ", "oʊ", "e", "eɪ", "æ", "ɪ", "iː", "uː", "ʌ", "ə", "ɜː", "p", "b", "f", "v", "k", "ɡ", "θ", "ð", "s", "z", "∫", "ʒ", "t", "d", "t∫", "dʒ", "j", "m", "n", "ŋ", "w", "r", "h", "l"];
  ipa_keys = ["'", "ˌ", "a:", "ai", "au", "o:", "oy", "uw", "ou", "e", "ei", "ea", "I", "i:", "u:", "^", "ow", "3:", "p", "b", "f", "v", "k", "ɡ", "th", "dd", "s", "z", "sx", "3y", "t", "d", "tsx", "d3y", "j", "m", "n", "ny", "w", "r", "h", "l"];
  sanitized_ans = ans;
  for (var i = ipa_keys.length - 1; i >= 0; i--) {
    sanitized_ans = sanitized_ans.replace(ipa_keys[i], ipa_list[i]);
  }
  return sanitized_ans;
};

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
