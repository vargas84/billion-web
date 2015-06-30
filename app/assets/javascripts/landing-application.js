var Billion = Billion || {};

Billion.Validation = {
	validateEmail: function(input) {
		// RFC 5322 specification
		// see http://stackoverflow.com/questions/46155/validate-email-address-in-javascript
		// escaped using http://www.freeformatter.com/javascript-escape.html
		var pattern = "(?:[a-z0-9!#$%&\'*+\/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&\'*+\/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

		if (input.match(pattern)) {
			return true;
		}
		else {
			return false;
		}
	},


};

// phone number masking
// on second thought, don't really want to do this because number might need extensions, or multiple numbers of instructions based on time of day, etc.
//$("#inputApplicationPhone").mask("999-999-9999");
// $("#inputApplicationPhone").on("blur", function() {
//     var last = $(this).val().substr( $(this).val().indexOf("-") + 1 );

//     if( last.length == 3 ) {
//         var move = $(this).val().substr( $(this).val().indexOf("-") - 1, 1 );
//         var lastfour = move + last;

//         var first = $(this).val().substr( 0, 9 );

//         $(this).val( first + '-' + lastfour );
//     }
// });

$(function() {
	$("#applicationForm").on("submit", function(e) {
		e.preventDefault();

		var $form = $(this);
		var $modal = $form.closest(".modal");
		var $spinner = $form.find(".fa-spin");

		$spinner.show();

		// validate the form

		// reset error styles
		$("#inputApplicationFirstName").removeClass("formElementError");
		$("#inputApplicationLastName").removeClass("formElementError");
		$("#inputApplicationEmail").removeClass("formElementError");
		$("#inputApplicationPhone").removeClass("formElementError");
		$("#inputApplicationName").removeClass("formElementError");
		$("#inputApplicationDescription").removeClass("formElementError");
		$("#inputApplicationTweet").removeClass("formElementError");
		$("#inputApplicationImpact").removeClass("formElementError");
		$("#inputApplicationProduct").removeClass("formElementError");

		$("#labelErrorContactFirstLastName").addClass("hidden");
		$("#labelErrorContactEmailPhone").addClass("hidden");
		$("#labelErrorName").addClass("hidden");
		$("#labelErrorDescription").addClass("hidden");
		$("#labelErrorTweet").addClass("hidden");
		$("#labelErrorImpact").addClass("hidden");
		$("#labelErrorProduct").addClass("hidden");

		// gather form inputs
		var firstName = $("#inputApplicationFirstName").val().trim();
		var lastName = $("#inputApplicationLastName").val().trim();
		var email = $("#inputApplicationEmail").val().trim();
		var phone = $("#inputApplicationPhone").val().trim();
		var name = $("#inputApplicationName").val().trim();
		// content-editable divs
		var description = $("#inputApplicationDescription").val().trim();
		var tweet = $("#inputApplicationTweet").val().trim();
		var impact = $("#inputApplicationImpact").val().trim();
		var product = $("#inputApplicationProduct").val().trim();

		// assume valid until proven otherwise
		var valid = true;

		if (firstName === "" || lastName === "") {
			valid = false;
			$("#labelErrorContactFirstLastName").text("What's your name?");
			$("#labelErrorContactFirstLastName").removeClass("hidden");

			if (firstName === "") {
				$("#inputApplicationFirstName").addClass("formElementError");
			}
			if (lastName === "") {
				$("#inputApplicationLastName").addClass("formElementError");
			}
		}

		if (email === "" || phone === "") {
			valid = false;
			$("#labelErrorContactEmailPhone").text("We need a way to get in touch with you!");
			$("#labelErrorContactEmailPhone").removeClass("hidden");

			if (email === "") {
				$("#inputApplicationEmail").addClass("formElementError");
			}
			if (phone === "") {
				$("#inputApplicationPhone").addClass("formElementError");
			}
		}

		// validate email syntax
		if (valid && !Billion.Validation.validateEmail(email)) {
			valid = false;
			$("#labelErrorContactEmailPhone").text("Check your email address again.");
			$("#labelErrorContactEmailPhone").removeClass("hidden");
			$("#inputApplicationEmail").addClass("formElementError");
		}

		// validate phone syntax
		// not currently doing

		// name
		if (name === "") {
			valid = false;
			$("#labelErrorName").text("Your movement wants a name!");
			$("#labelErrorName").removeClass("hidden");
			$("#inputApplicationName").addClass("formElementError");
		}

		// description
		if (description === "") {
			valid = false;
			$("#labelErrorDescription").text("Tell us about the issue you want to solve!");
			$("#labelErrorDescription").removeClass("hidden");
			$("#inputApplicationDescription").addClass("formElementError");
		}

		// tweetable
		if (tweet === "") {
			valid = false;
			$("#labelErrorTweet").text("Give us a tweetable summary of your movement!");
			$("#labelErrorTweet").removeClass("hidden");
			$("#inputApplicationTweet").addClass("formElementError");
		}

		// impact
		if (impact === "") {
			valid = false;
			$("#labelErrorImpact").text("Tell us about your impact!");
			$("#labelErrorImpact").removeClass("hidden");
			$("#inputApplicationImpact").addClass("formElementError");
		}

		// product or service
		if (product === "") {
			valid = false;
			$("#labelErrorProduct").text("Tell us about your product or service!");
			$("#labelErrorProduct").removeClass("hidden");
			$("#inputApplicationProduct").addClass("formElementError");
		}

		if (!valid) {
			$spinner.hide();
			return;
		}

		// copy content editables to hidden form elements
		$("#hiddenApplicationDescription").val(description);
		$("#hiddenApplicationTweet").val(tweet);
		$("#hiddenApplicationImpact").val(impact);
		$("#hiddenApplicationProduct").val(product);

		var data = $form.serializeArray();
		var json = {};
		data.forEach(function(field) {
			json[field.name] = field.value;
		});

		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'),
			dataType: 'json',
			data: json,
			success: function(data) {
				$spinner.hide();
				$form[0].reset();
				$modal.modal('hide');
			},
			error: function(jqXHR) {
				$spinner.hide();
			},
		});
	});

});
