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

$(function(){
  $('input[type=search]').focus(function(){
    $(".right-container").hide();
  }).blur(function(){
    $(".right-container").show();
  });

  $('input[type=search]').focus(function(){
    $(".left-container").hide();
  }).blur(function(){
    $(".left-container").show();
  });
});