// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require moment
//= require bootstrap-datetimepicker

// Datetimepicker - http://eonasdan.github.io/bootstrap-datetimepicker/#example6

jQuery(document).ready(function() {
	initEvent();
});

jQuery(document).on('page:change, page:load', initEvent);


function initEvent(){
  // Datetime picker for edit form
    jQuery('.datetimepicker').datetimepicker();

	readjustEventHeights();

	$( window ).resize(function() {
		if ($(this).width() <= 768){
			$(".description").each(function( index, value ){
				$(this).height('auto');
			});

		} else{
			readjustEventHeights();

		}
		// $( "#log" ).append( "<div>Handler for .resize() called.</div>" );
	});
}


// Find the longest event and readjust all heights to that event heght
function readjustEventHeights(){
	var maxHeight = 0;

	// Determine the maximum height
	jQuery(".description").each(function( index, value ){
		var height = $(this).height();
		if (maxHeight < height){
			maxHeight = height;
		}
	});
	// Change each description's height to maximum height 
	jQuery(".description").each(function( index, value ){
		$(this).height(maxHeight);
	});
}