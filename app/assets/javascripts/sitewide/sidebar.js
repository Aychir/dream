$(function() {
    $(".panel-collapse").on("click", function(e) {
        e.stopPropagation();
    });
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
		}
	});
});

/*
	As we resize the window, we must check if the sidebar is collapsed- if it is and the
	window is under 960px, we must undo the effects of the collapsed sidebar. On the other hand
	if the overlay effect is active, then when it is too big- we want to let the overlay go.
*/
$(window).resize(function(){
	if($('#sidebar').hasClass('active') && $(window).width() <= 960){
		$('#sidebar').toggleClass('active');
        $('#content').toggleClass('active');
	}

	if($('#sidebar').hasClass('sidebarOverlay') && $(window).width() > 960){
		$(".overlay").toggleClass('blockDisplay');
		$('#sidebar').toggleClass('sidebarOverlay');
		$('.col-12 td').toggleClass('noClick');
	}
});

$(function(){
	$('#content').on('click', function(){
		if($('.overlay').hasClass('blockDisplay')){
			$(".overlay").toggleClass('blockDisplay');
			$('#sidebar').toggleClass('sidebarOverlay');
			$('.col-12 td').toggleClass('noClick');
		}
	});
});

/*
	This function will toggle class bottomZero (initially used) because bottom: 0 is set in there
	and this will allow the only relative ancestor to be the body, so it will position at the bottom
	of the sidebar. When clicking the link, we first expand/collapse the list for transition purposes
	and toggle bottomZero, this takes off the bottome attribute and allows the element to overflow to 
	the bottom of the document- in its original position because it has no TLBR attributes set.
*/
$(function(){
	$('.panel-title a').on('click', function(){
		//This may not work for all browsers- a better approach could be youtube style revealing part of the sidebar and preventing 
		//	spam from being possible
		$(".panel-title a").css("pointer-events", "none");
		//Do this because the timing of the about section was off when collapsing collapse1
		if($("#collapse1").css('display') == 'none'){
			$("#collapse1").css('display', 'block');
		}
		else{
	 		//We want to make it do nothing until the display is none
	 		$("#collapse1").css('display', 'none');
		}
		//This should only toggle if the following height is long enough to push it past bottom - 0
		$('.about-section').toggleClass('bottomZero');
		$(".panel-title a").css("pointer-events", "auto");
	});
});