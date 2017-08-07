$(document).ready(function() {
  if($(window).width() < 768) {
    $('#resizing_list').addClass('list-inline');
    $('#resizing_list').removeClass('list-group');
  }else{
    $('#resizing_list').addClass('list-group');
    $('#resizing_list').removeClass('list-inline');
  }

  $(window).on('resize', function() {
    if($(window).width() < 768) {
      $('#resizing_list').addClass('list-inline');
      $('#resizing_list').removeClass('list-group');
    }else{
      $('#resizing_list').addClass('list-group');
      $('#resizing_list').removeClass('list-inline');
    }
  });
});
