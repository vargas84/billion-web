$(document).ready(function() {
  var $join = $('#landing-join'),
      $landingEmailForm = $join.find('form'),
      $landingEmailInput = $join.find('.landing-email-input'),
      $landingEmailSubmit = $join.find('.landing-email-submit'),
      $landingEmailSpinner = $landingEmailSubmit.find('.fa-spinner'),
      $landingSubmitText = $landingEmailSubmit.find('.landing-submit-text'),
      $successMsg = $join.find('.alert-success'),
      $failureMsg = $join.find('.alert-danger'),
      subscribePath = window.config.subscribePath,
      authenticityToken = window.config.authenticityToken;

  $landingEmailForm.on('submit', function(e) {
    e.preventDefault();

    var email = $landingEmailInput.val(),
        data = { authenticity_token: authenticityToken, email: email };

    if (email) {
      $.post(subscribePath, data, success).fail(failure);
      $landingEmailSpinner.removeClass('hide');
      $landingSubmitText.addClass('hide');
      $landingEmailSubmit.prop('disabled', true);
    }

    function success() {
      $successMsg.removeClass('hide');
      $failureMsg.addClass('hide');
      $landingEmailSpinner.addClass('hide');
      $landingSubmitText.removeClass('hide');
    }

    function failure() {
      $failureMsg.removeClass('hide');
      $successMsg.addClass('hide');
      $landingEmailSubmit.prop('disabled', false);
      $landingEmailSpinner.addClass('hide');
      $landingSubmitText.removeClass('hide');
    }
  });
});
