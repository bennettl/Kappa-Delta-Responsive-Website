// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready(function($){
	(function(){
		var maxHeight = 0;

		// Determine the maximum height
		$(".summary").each(function( index, value ){
			var height = $(this).height();
			if (maxHeight < height){
				maxHeight = height;
			}
		});
		// Change each summary's height to maximum height 
		$(".summary").each(function( index, value ){
			//$(this).css('min-height', maxHeight);
		});
	}());
});
