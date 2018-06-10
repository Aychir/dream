$(function() {
    $(".panel-collapse").on("click", function(e) {
        e.stopPropagation();
    });
});

$(function(){
	$('#sidebarCollapse').on('click', function(){
		if($(window).width() > 960){
			$('#sidebar').toggleClass('active');
        	$('#content').toggleClass('active');
		}
		else{
			$('body').toggleClass('overlay');
			$('#sidebar').toggleClass('sidebarOverlay');
			$('.col-12 td').toggleClass('noClick');
		}
	});
});

$(window).resize(function(){
	if($('#sidebar').hasClass('active') && $(window).width() <= 960){
		$('#sidebar').toggleClass('active');
        $('#content').toggleClass('active');
	}

	if($('#sidebar').hasClass('sidebarOverlay') && $(window).width() > 960){
		$('body').toggleClass('overlay');
		$('#sidebar').toggleClass('sidebarOverlay');
		$('.col-12 td').toggleClass('noClick');
	}
});

$(function(){
	$('#content').on('click', function(){
		if($('body').hasClass('overlay')){
			$('body').toggleClass('overlay');
			$('#sidebar').toggleClass('sidebarOverlay');
			$('.col-12 td').toggleClass('noClick');
		}
	});
});