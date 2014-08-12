// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http: //coffeescript.org/

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui-1.10.4.custom.min

jQuery(document).ready(function($) {
    // Make links ajax
    // $("#members").on('click', 'a', function() {
    //     // Get the javascript file from index action
    //     $.getScript(this.href);
    //     return false;
    // });

    // Reloads list in real time every time the member types
    $("input.search_column").keyup(function(event) {
        var memberSearchForm = $("#member_search");
        var path = memberSearchForm.attr('action');
        var info = memberSearchForm.serialize();
        $.get(path, info, null, "script");
    });

    // Autocompletion
    // $("input.search_column").autocomplete({
    //     source: function(request, response) {
    //         var inputField = $(this.element);
    //         var columnType = inputField.attr('data-column-type');

    //         $.ajax({
    //             url: "https://thekds.org/members/autocomplete",
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
        // select: function(event, ui) {
        //     log(ui.item ?
        //         "Selected: " + ui.item.label :
        //         "Nothing selected, input was " + this.value);
        // },
        // open: function() {
        //     $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        // },
        // close: function() {
        //     $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        // }
    // });
});