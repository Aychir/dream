$(function() {
    $(".panel-collapse").on("click", function(e) {
        e.stopPropagation();
    });
});

$(function(){
	$('#sidebarCollapse').on('click', function(){
		if($(window).width() > 768){
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