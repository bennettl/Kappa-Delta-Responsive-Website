// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui-1.10.4.custom.min
//= require moment
//= require bootstrap-datetimepicker

// Datetimepicker - http://eonasdan.github.io/bootstrap-datetimepicker/#example6

(function(){
    jQuery(document).ready(function($) {
        initJob();
    });

    jQuery(document).on('page:change, page:load', initJob);

    function initJob(){
        // Datepicker (only date)
        jQuery('.datetimepicker').datetimepicker({pickTime: false, format: 'YYYY-MM-DD'});

        // Reloads list in real time every time the member types
        jQuery("input.search_column").on('keyup blur', function(event) {
            var jobSearchForm = $("#job_search");
            var path = jobSearchForm.attr('action');
            var info = jobSearchForm.serialize();
            $.get(path, info, null, "script");
        });

        // Autocompletion
        // jQuery("input.search_column").autocomplete({
        //     source: function(request, response) {
        //         var inputField = $(this.element);
        //         var columnType = inputField.attr('data-column-type');

        //         $.ajax({
        //             url: "http://localhost:3000/jobs/autocomplete",
        //             dataType: "json",
        //             data: {
        //                 value: request.term,
        //                 column: columnType
        //             },
        //             success: function(data) {
        //                 response(data);
        //                 // response($.map(data, function(item) {
        //                 //     return {
        //                 //         label: item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
        //                 //         value: item.name
        //                 //     }
        //                 // }));
        //             }
        //         });
        //     },
        //     minLength: 2,
        //     // select: function(event, ui) {
        //     //     log(ui.item ?
        //     //         "Selected: " + ui.item.label :
        //     //         "Nothing selected, input was " + this.value);
        //     // },
        //     // open: function() {
        //     //     $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        //     // },
        //     // close: function() {
        //     //     $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        //     // }
        // });
    }
}());
