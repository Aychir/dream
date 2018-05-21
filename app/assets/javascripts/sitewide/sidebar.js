$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        // open or close navbar
        $('#sidebar').toggleClass('active');
        $('#content').toggleClass('active');
    });

});

$(function() {
    $(".panel-collapse").on("click", function(e) {
        e.stopPropagation();
    });
});