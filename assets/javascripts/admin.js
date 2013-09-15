//= require jquery
//= require jquery-ujs
//= require jquery-ui
//= require chosen.jquery

$(document).ready(function(e) {
	var docHeight = $(document).height();
	var docWidth = $(document).width();
	var topBarHeight = $('#topBar').height();
	var leftNavWidth = $('#leftNav').width();
	var rightBoxHeight = $('#rightBox').height();
	
	$('#leftNav').height(rightBoxHeight + 40);
	$('#rightBox').width(docWidth-leftNavWidth);
	
	$(window).resize(function() {
		docWidth = $(document).width();
		
		$('#rightBox').width(docWidth-leftNavWidth);
	});
});
