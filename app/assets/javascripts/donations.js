$(document).ready(function(){
	// Set stripe public key
	var public_key = $('meta[name="strip_key"]').attr('content');
	Stripe.setPublishableKey(public_key);

	// Every time the custom amount is enter, checked and change the attribute on the corresponding radio button
	$('[name="amount_custom"]').on('keyup', function(){
		var value = $(this).val();
		$('#donation_amount_0').prop("checked", true);
		$('#donation_amount_0').val(value);
	});

	// Create a stripe token when donation form submits
	$('#new_donation').on('submit', function(){
		var number 		= $('input[name="number"]').val();
		var cvc 		= $('input[name="cvc"]').val();
		var exp_month 	= $('#exp_month').val();
		var exp_year 	= $('#exp_year').val();

		var cardData = {number: number,
				    cvc: cvc,
				    exp_month: exp_month,
				    exp_year: exp_year
					};

		// If custom amount radio button is check, validate it
		var customRadioIsChecked = $('#donation_amount_0').is(':checked');
		if (customRadioIsChecked){
			// Allow only digits
			var reg = /^\d+$/;
			var customValue = $('[name="amount_custom"]').val();
			if (!reg.test(customValue)){
		        $('.error').text('Please enter numeric values only for custom amount');
				return false;
			}
		}

		Stripe.card.createToken(cardData, stripeResponseHandler);

		return false;
	});

	// Append toke to donation form and resubmit
	function stripeResponseHandler(status, response) {
		if (response.error) {
	        // show the errors on the form
	        $('.error').text(response.error.message);
	    } else {
	        var form = $('#new_donation');
	        // token contains id, last4, and card type
	        var token = response['id'];
	        console.log(token);
	        // insert the token into the form so it gets submitted to the server and submit
	        form.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
	        form.get(0).submit();
	    }
	}
});