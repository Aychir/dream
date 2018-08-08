$(document).ready(function() {
  $(".error-inner").css({
    'margin-left': ($(".error-inner").css('margin-right') + 'px')
  });

  $(".error-sheet").css({
  	'padding-top': ($("body").outerHeight()/2 + 'px')
  });
});