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

$(document).ready(function() {
	$('input[type="search"]').on('focus', function() {
	    $('.right-container').hide();
	});
});

$(document).ready(function() {
	$('input[type="search"]').off('focus', function() {
	    $('.right-container').show();
	});
});