(function($) {
  'use strict';

  function DonationForm(form, braintreeToken, dollarToPoint) {
    setupBraintree(form, braintreeToken);
    setupPointConverter(
      $(form).find('.dollar-container'),
      $(form).find('.point-container'),
      dollarToPoint
    );
  };

  function setupPointConverter($dollarContainer, $pointContainer, dollarToPoint) {
    var $dollarInput = $dollarContainer.find('input');
    var $pointValue = $pointContainer.find('.point-value');
    var $pointUnit = $pointContainer.find('.point-unit');

    $dollarInput.autoNumeric('init');

    $dollarInput.on('change', function() {
      var dollar = parseFloat($dollarInput.val()) || 0;
      $pointValue.text(convertToPoint(dollar, dollarToPoint))
    });

  }

  function convertToPoint(dollar, dollarToPoint) {
    return Math.ceil(dollar * dollarToPoint);
  }

  function pluralizePoint(point) {
    point == 1 ? 'point' : 'points';
  }

  function setupBraintree(form, braintreeToken) {
      var $form = $(form);
      var form_id = $form.attr('id');

      braintree.setup(
        braintreeToken,
        'custom', {
          id: form_id,
          hostedFields: {
            styles: {
              'input': {
                'font-size': '14px',
                'font-family': 'Open Sans',
                'color': '#222222',
              }
            },
            number: {
              selector: '#' + form_id + ' .card-number'
            },
            cvv: {
              selector: '#' + form_id + ' .cvv'
            },
            expirationDate: {
              selector: '#' + form_id + ' .expiration-date'
            }
          },
          onReady: function() {
            $form.find('.payment-form').removeClass('loading');
            $form.find('.payment-spinner').remove();
            $form.find('.disabled').removeClass('disabled');
            $form.find('[disabled]').prop('disabled', false);
          }
        });
    }

  DonationForm.prototype = {
  };

  window.DonationForm = DonationForm;
}(jQuery));
