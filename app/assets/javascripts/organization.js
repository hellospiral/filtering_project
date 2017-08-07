$(document).ready(function() {
  if ($(window).width() < 768) {
    $('#resizing_list').addClass('list-inline');
    $('#resizing_list').removeClass('list-group');
  } else {
    $('#resizing_list').addClass('list-group');
    $('#resizing_list').removeClass('list-inline');
  }

  if ($(window).width() < 420 || $(window).width() > 768 && $(window).width() < 1200 ) {
    $('#accepts_any').text("Matches any filter");
    $('#accepts_all').text("Matches all filters");
  }

  $(window).on('resize', function() {
    if ($(window).width() < 768) {
      $('#resizing_list').addClass('list-inline');
      $('#resizing_list').removeClass('list-group');
    } else {
      $('#resizing_list').addClass('list-group');
      $('#resizing_list').removeClass('list-inline');
    }

    if ($(window).width() < 420 || $(window).width() > 768 && $(window).width() < 1200 ) {
      $('#accepts_any').text("Matches any filter");
      $('#accepts_all').text("Matches all filters");
    } else {
      $('#accepts_any').text("Find organizations that accept any of these");
      $('#accepts_all').text("Find organizations that accept all of these");
    }
  });
});
