$(function(){
	$("#the-up-arrow").on('click', function(){
		$("#the-up-arrow").toggleClass("upvoted");
		if ($("#the-down-arrow").hasClass("downvoted")){
			$("#the-down-arrow").removeClass("downvoted")
		}
	});

	$("#the-down-arrow").on('click', function(){
		$("#the-down-arrow").toggleClass("downvoted");
		if ($("#the-up-arrow").hasClass("upvoted")){
			$("#the-up-arrow").removeClass("upvoted")
		}
	});
});
