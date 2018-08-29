$(function() {
    $(".panel-collapse").on("click", function(e) {
        e.stopPropagation();
    });
});

var $width = $(window).width();

$(function(){
	if($(window).width() <= 960){
		$('#content').addClass('active');
		$('#sidebar').addClass('active');
	}	
});


//If the window > 960px, just collapse the sidebar- else we need the overlay effect
$(function(){
	$('#sidebarCollapse').on('click', function(){
		if($(window).width() > 960){
			$('#sidebar').toggleClass('active');
        	$('#content').toggleClass('active');
		}
		else{
			$(".overlay").toggleClass('blockDisplay');
			$('#sidebar').toggleClass('sidebarOverlay');
			$('.col-12 td').toggleClass('noClick');
			if($('#sidebar').hasClass('sidebarOverlay')){
				$('#sidebar').removeClass('active');
			}
			else{
				$('#sidebar').addClass('active');
			}
		}
	});
});

/*
	As we resize the window, we must check if the sidebar is collapsed- if it is and the
	window is under 960px, we must undo the effects of the collapsed sidebar. On the other hand
	if the overlay effect is active, then when it is too big- we want to let the overlay go.
*/
$(window).resize(function(){
	if(!($('#sidebar').hasClass('active')) && $(window).width() <= 960){
		if(!($('#sidebar').hasClass('sidebarOverlay'))){
			$('#sidebar').addClass('active');
        	$('#content').addClass('active');
    	}
	}

	//How to differentiate from small to big and from big to big
	if(($('#content').hasClass('active')) && $(window).width() > 960 && $width <= 960){
		$('#sidebar').removeClass('active');
        $('#content').removeClass('active');
	}

	if($('#sidebar').hasClass('sidebarOverlay') && $(window).width() > 960){
		$(".overlay").toggleClass('blockDisplay');
		$('#sidebar').toggleClass('sidebarOverlay');
		$('.col-12 td').toggleClass('noClick');
		$('#content').removeClass('active');
	}

	$width = $(window).width();
});

$(function(){
	$('.overlay').on('click', function(){
		if($('.overlay').hasClass('blockDisplay')){
			$(".overlay").toggleClass('blockDisplay');
			$('#sidebar').toggleClass('sidebarOverlay');
			$('.col-12 td').toggleClass('noClick');
			$('#sidebar').addClass('active');
		}
	});
});

/*
	This function will toggle class bottomZero (initially used) because bottom: 0 is set in there
	and this will allow the only relative ancestor to be the body, so it will position at the bottom
	of the sidebar. When clicking the link, we first expand/collapse the list for transition purposes
	and toggle bottomZero, this takes off the bottom attribute and allows the element to overflow to 
	the bottom of the document- in its original position because it has no TLBR attributes set.
*/
$(function(){
	$('#down-arrow a').on('click', function(){
		$("#collapse1").css('display', 'block');
		//If content overflows sidebar height, we want to remove bottom: 0 and make the switch to the up arrow
		if($('#collapse1').height() > $('#sidebar').height()){
			$("#down-arrow").css('display', 'none');
			$("#up-arrow").css('display', 'inline-block');
			//$('.about-section').removeClass('bottomZero');
		}
		//We want to change to up arrow only if the user actually follows someone (already check for authenticated user)
		else if($('#collapse1').height() < $('#sidebar').height() && $('#collapse1').height() > 0){
			$("#down-arrow").css('display', 'none');
			$("#up-arrow").css('display', 'inline-block');
		}
	});

	//Up arrow should always come reverse the effects, no matter what
	$('#up-arrow a').on('click', function(){
		$("#collapse1").css('display', 'none');
		$("#down-arrow").css('display', 'inline-block');
		$("#up-arrow").css('display', 'none');
		//$('.about-section').addClass('bottomZero');
	});
});
