$(document).ready(function() {
  $(".right-container").css({
    'width': ($(".left-container").width() + 'px')
  });
});

$(window).resize(function() {
 $(".right-container").css({
    'width': ($(".left-container").width() + 'px')
  });
});