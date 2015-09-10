(function($) {
  'use strict';

  function DonationForm(form, braintreeToken, dollarToPoint) {
    setupPointConverter(
      $(form).find('.dollar-container'),
      $(form).find('.point-container'),
      dollarToPoint
    );

    setupFormValidation(form);

    setupBraintree(form, braintreeToken);
  };

  function setupPointConverter($dollarContainer, $pointContainer, dollarToPoint) {
    var $dollarInput = $dollarContainer.find('input');
    var $pointValue = $pointContainer.find('.point-value');
    var $pointUnit = $pointContainer.find('.point-unit');

    $dollarInput.autoNumeric('init');

    $dollarInput.on('keyup', function() {
      var dollar = parseFloat($dollarInput.autoNumeric('get')) || 0;
      $pointValue.text(convertToPoint(dollar, dollarToPoint))
    });

    $dollarInput.trigger('keyup');
  }

  function setupFormValidation(form) {
    var $form = $(form);
    $form.validate({
      highlight: function(element) {
        if ($(element).hasClass('inline-form-field')) {
          $(element).addClass('invalid');
        } else {
          $.validator.defaults.highlight.apply(this, arguments);
        }
      },
      unhighlight: function(element) {
        if ($(element).hasClass('inline-form-field')) {
          $(element).removeClass('invalid');
        } else {
          $.validator.defaults.unhighlight.apply(this, arguments);
        }
      },
      errorPlacement: function(error, element) {
        if (!$(element).hasClass('inline-form-field')) {
          $.validator.defaults.errorPlacement.apply(this, arguments);
        }
      },
    });
  }

  function convertToPoint(dollar, dollarToPoint) {
    return Math.ceil(dollar * dollarToPoint).toLocaleString();
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
          },

          onPaymentMethodReceived: function(obj) {
            if ($form.valid()) {
              var money = $form.find('.amount-field').val();
              var project = $form.find('.project-select option:selected').text()
              var message = 'You are about to donate ' + money + ' in support of ' + project + '.';
              message += '\n\nDo you wish to continue?'
              if (confirm(message)) {
                $form.append($("<input name='payment_method_nonce' value='" + obj.nonce + "'/>"));
                $form.submit();
              }
            }
          }
        });
    }

  window.DonationForm = DonationForm;
}(jQuery));
