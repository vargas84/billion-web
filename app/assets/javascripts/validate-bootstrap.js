(function() {
  /* See
   * http://stackoverflow.com/questions/18754020/bootstrap-3-with-jquery-validation-plugin
   */
  'use strict';

  $.validator.setDefaults({
    highlight: function(element) {
      $(element).closest('.form-group').addClass('has-error');
    },
    unhighlight: function(element) {
      $(element).closest('.form-group').removeClass('has-error');
    },
    errorElement: 'span',
    errorClass: 'help-block',
    errorPlacement: function(error, element) {
      if(element.parent('.input-group').length) {
        error.insertAfter(element.parent());
      } else {
        error.insertAfter(element);
      }
    }
  });

  $.validator.addMethod('autonumeric', function(value, element, params) {
    //debugger;
    var num = parseFloat(value.replace(/[^\d\.]/, ''));

    var isNumber = !isNaN(num),
        satisfyMin = isNumber && present(params.min) ? num >= params.min : true,
        satisfyMax = isNumber && present(params.max) ? num >= params.max : true;

    return this.optional(element) || (isNumber && satisfyMin && satisfyMax);
  });

  function present(value) {
    return typeof value !== 'undefined' && value !== null
  }
}());
