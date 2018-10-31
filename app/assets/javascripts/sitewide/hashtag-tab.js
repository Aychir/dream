$(function(){
	$('#bottom-tab-icon').on('click', function(){
		$("#bottom-tab").toggleClass("expanded");

		$("#hidden-tab-container").toggleClass("expanded");
	});
});