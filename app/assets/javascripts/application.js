// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require forem
//= require bootstrap-wysihtml5
//= require bootsy

// Remove //= require_tree because we don't want to include all javascript files

// Mobile Menu Concerns go in this object
var mobileMenu = {
	togglemenu : function() {
		jQuery('.siteWrap').toggleClass('menuOpen');
	}
};

jQuery(document).ready(function($) {
	jQuery('.menuToggle').on('click', mobileMenu.togglemenu);
	// alert('hey');
});

