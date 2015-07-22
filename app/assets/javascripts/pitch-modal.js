(function() {
  'use strict';

  function PitchModal(el) {
    var $el = this.$el = $(el);
    this.$form = this.$el.find('form');
    this.$alert = this.$el.find('.alert');
    this.$submit = this.$el.find('button[type=submit]');

    _.bindAll(this, 'onSubmit', 'onSuccess', 'onError');

    $el.find('form').validate({
      rules: {
        phone: {
          required: true,
          phoneUS: true
        }
      },
      submitHandler: this.onSubmit
    });
  }

  PitchModal.prototype = {
    onSubmit: function(form) {
      var $form =$(form);
      this.$alert.addClass('hide');
      this.$submit.prop('disabled', true);

      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'json',
        data: $form.serialize(),
        error: this.onError,
        success: this.onSuccess
      });

    },
    onSuccess: function() {
      this.$form.remove();
      this.$el.find('.pitch-success-content').removeClass('hide');
    },
    onError: function(jqXHR) {
      switch (jqXHR.status) {
        case 422:
          this.addValidationErrors(jqXHR.responseJSON.errors);
          break;
        default:
          this.addGeneralError();
      }

      this.$submit.prop('disabled', false);
      this.$el.scrollTop(0);
    },
    addValidationErrors: function(errorsMessages) {
      this.addErrors(errorsMessages)
    },
    addGeneralError: function() {
      this.addErrors(['Something went wrong during the submission. Please try again later.'])
    },
    addErrors: function(errorMessages) {
      if (errorMessages.length === 1) {
        this.$alert.html(errorMessages);
      } else {
        var $ul = $('<ul></ul>');
        _.forEach(errorMessages, function(msg) {
          $ul.append($('<li>' + msg + '</li>'));
        });
        this.$alert.html($ul);
        this.$alert.removeClass('hide');
      }
    }
  };

  window.Billion = window.Billion || {};

  Billion.PitchModal = PitchModal;
}());
