$(function(){
	$('#bottom-tab-icon').on('click', function(){
		$("#bottom-tab").fadeToggle("slow", function () {
			$("#bottom-tab").toggleClass("expanded");
		});

		$("#hidden-tab-container").fadeToggle("slow", function () {
			$("#hidden-tab-container").toggleClass("expanded");
		});
	});
});