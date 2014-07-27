var mobileMenu = {
	togglemenu : function() {
		$('.siteWrap').toggleClass('menuOpen');
	}
};

jQuery(document).ready(function() {
	initStaticPages();
});

jQuery(document).on('page:change, page:load', initStaticPages);


function initStaticPages(){
	jQuery('.menuToggle').on('click', mobileMenu.togglemenu);

	jQuery('.contact-box').on('click', function(event) {
		// Toggle current class
		jQuery('.contact-box.current').removeClass('current');
		jQuery(this).addClass('current');

		// Change the email to value accordingly
		var email_from = jQuery(this).attr('href').substr(1);
		jQuery('input[name="email_to"]').val(email_from);

		console.log(email_from);
		
		return false;
	});
}