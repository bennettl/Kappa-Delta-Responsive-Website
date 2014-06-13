// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

//= require moment
//= require bootstrap-datetimepicker


(function(){
    jQuery(document).ready(function($) {
        initDagger();
    });

    jQuery(document).on('page:change, page:load', initDagger);

    function initDagger(){
        // Datepicker (only date)
        jQuery('.datetimepicker').datetimepicker({pickTime: false});
    }

}());
