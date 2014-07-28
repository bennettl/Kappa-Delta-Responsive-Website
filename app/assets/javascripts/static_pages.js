jQuery(document).ready(function() {
	initStaticPages();
});

jQuery(document).on('page:change, page:load', initStaticPages);


function initStaticPages(){
	var mobileMenu = {
		togglemenu : function() {
			var siteWrap = jQuery('.siteWrap').eq(0);
			if (siteWrap.hasClass('menuOpen')){
				siteWrap.addClass('menuOpen');
			} else{
				siteWrap.removeClass('menuOpen');
			}
		}
	};

	jQuery('body').on('click', '.menuToggle', mobileMenu.togglemenu);

	jQuery('.contact-box').on('click', function(event) {
		// Toggle current class
		jQuery('.contact-box.current').removeClass('current');
		jQuery(this).addClass('current');

		// Change the email to value accordingly
		var email_from = jQuery(this).attr('href').substr(1);
		jQuery('input[name="email_to"]').val(email_from);

		// console.log(email_from);
		
		return false;
	});
}