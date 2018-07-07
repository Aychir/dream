//First two functions for ensuring the right half of the navbar is the same width as the left half so the search bar will be centered.
$(document).ready(function() {
  $(".right-container").css({
    'width': ($(".left-container").width() + 'px')
  });

  $(".btn-outline-secondary").css({
    'height': ($("input.form-control").outerHeight() + 'px')
  })

  $("#content").css({
    'padding-top': ($("nav.navbar").height() + 16 + 'px')
  });
});

$(window).resize(function() {
 $(".right-container").css({
    'width': ($(".left-container").width() + 'px')
  });

 $(".btn-outline-secondary").css({
    'height': ($("input.form-control").outerHeight() + 'px')
  });

 $("#content").css({
    'padding-top': ($("nav.navbar").height() + 16 + 'px')
  });
});

//Collapsing of the left & right sides of navbar when screen too small
$(function(){
      $('input[type=search]').focus(function(){
        if($(window).width() <= 648){
          $(".right-container").hide(350);
        }}).blur(function(){
        if($(window).width() <= 648){
          $(".right-container").show(410);
        }});

      $('input[type=search]').focus(function(){
        if($(window).width() <= 648){
          $(".left-container").hide(350);
        }}).blur(function(){
        if($(window).width() <= 648){
          $(".left-container").show(350);
        }});
});

$(window).resize(function(){
  if($('input[type=search]').is(':focus')){
    if($(window).width() <= 648){
      $(".left-container").hide(300);
      $(".right-container").hide(300);
    }
    else{
      $(".left-container").show(300);
      $(".right-container").show(410);
    }
  }
});