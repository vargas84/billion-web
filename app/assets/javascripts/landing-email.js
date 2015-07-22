(function() {
  'use strict';

  function SubscribeForm(form) {
    this.$el = $(form);
    this.$submit = this.$el.find('[type=submit]');
    this.$alertSuccess = this.$el.find('.js-alert-success');
    this.$alertError = this.$el.find('.js-alert-error');
    this.$emailGroup = this.$el.find('.js-email-group');

    _.bindAll(this, 'onSubmit', 'onSuccess', 'onError');
    this.$el.validate({submitHandler: this.onSubmit});
  }

  SubscribeForm.prototype = {
    onSubmit: function() {
      this.toggleButton();
      $.ajax({
        url: this.$el.attr('action'),
        method: this.$el.attr('method'),
        data: this.$el.serialize(),
        success: this.onSuccess,
        error: this.onError
      });
    },
    onSuccess: function() {
      this.$alertError.addClass('hide');
      this.$alertSuccess.removeClass('hide');
      this.$emailGroup.remove();
    },
    onError: function(jqXHR) {
      var message;
      switch(jqXHR.status) {
        case 400:
          message = jqXHR.responseJSON.message;
          this.$el.find('input[type=email]').focus()[0].select();
          break;
        default:
          message = 'Something went wrong. Please try again later.'
      }
      this.toggleButton();
      this.$alertError.removeClass('hide');
      this.$alertError.find('.error-message').text(message)
    },
    toggleButton: function() {
      this.$submit.prop('disabled', !this.$submit.prop('disabled'));
      this.$el.find('.js-spin-icon').toggleClass('hide');
      this.$el.find('.js-submit-icon').toggleClass('hide');
    }
  };

  window.Billion = window.Billion || {};
  window.Billion.SubscribeForm = SubscribeForm;
}());
