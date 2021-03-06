//Click the icon, get the search form and its button
$(function(){
	$('#searchIconButton').on('click', function(event){
		event.stopPropagation();

		if($(window).width() < 720){
			$('#left-elements').hide();
			$('.right-elements').hide();
			$('input.searchBox').toggleClass('narrowSearch');
			//$('#navSecondHalf').toggleClass('ml-auto');
			$('input.searchBox').toggleClass('narrowSearch');
			$('#navSecondHalf').addClass('mr-auto');
		}

		//if($(window).width() < 540)

		$("#searchIconButton").toggle();
		$("#searchForm").toggle();
		$("button.search").css({
     		'height': ($("input.searchBox").outerHeight() + 'px')
  		 });
	});
	$('#searchForm').on('click', function(event){
		event.stopPropagation();
	});
});

//Click anywhere away from the visible search form, make it disappear and have the icon reappear
$("body").click(function(){
	if($("#searchIconButton").css('display') == 'none') {
		$("#searchIconButton").toggle();
		$("#searchForm").toggle();
		$('#left-elements').show();
		$('.right-elements').show();
		if($(window).width() < 360){
			$('#square').hide();
		}
		$('#navSecondHalf').removeClass('mr-auto');
	}
});

/*
	This function checks if we pass the threshold for the search bar of 720px when the search bar is meant
	to be expanded. If it is expanded and the window becomes smaller than 720, we want to hide all other
	elements and shift the box to the middle- if you expand back out, you show the elements and take off the
	right margin added.

	The second half says that if the search form is active (in a different way than above) then once we get
	below 420 ;) then make it disappear. On the flip side, if it gets bigger than the threshold, then change it 
	to an inline element (i.e. make it show up)
*/
$(window).resize(function() {
	if($(window).width() > 760 && $("#searchIconButton").css('display') == 'none'){
		$('#left-elements').show();
		$('.right-elements').show();
		$('#navSecondHalf').removeClass('mr-auto');
	}

	else if($(window).width() <= 760 && $("#searchIconButton").css('display') == 'none'){
		$('#left-elements').hide();
		$('.right-elements').hide();
		$('#navSecondHalf').addClass('mr-auto');
	}

	if($(window).width() < 420 && $("button.search").css('display') != 'none'){
		$("button.search").css({
			'display': 'none'
		});
	}
	else if($(window).width() >= 420 && $("button.search").css('display') == 'none'){
		$("button.search").css({
			'display': 'inline'
		});
	}
});

//Code to have the log-in button match width of sign up button
$(document).ready(function() {
  $(".btn-outline-primary").css({
    'width': ($(".btn-primary").outerWidth() + 'px')
  });
});

$(window).resize(function() {
	$(".btn-outline-primary").css({
    'width': ($(".btn-primary").outerWidth() + 'px')
  });
});


//Function to make the 'avatar' disappear for mobile width screens
$(function(){
	if($(window).width() <= 360){
		$("#square").hide();
	}
});

$(window).resize(function(){
	if($(window).width() <= 360){
		$("#square").hide();
	}
	else if($(window).width() > 360 && $("#searchIconButton").css('display') != 'none'){
		$("#square").show();
	}
});
