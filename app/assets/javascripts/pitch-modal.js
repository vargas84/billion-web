(function() {

  function PitchModal(el) {
    var $el = $(el);

    $el.find('form').validate({
      rules: {
        phone: {
          required: true,
          phoneUS: true
        }
      },
      submitHandler: function(form) {
        var $form =$(form);
        $form.find('button[type=submit]').prop('disabled', true);

        $.ajax({
          url: '/bam_applications',
          method: 'POST',
          dataType: 'json',
          data: $form.serialize(),
          error: function(jqXHR) {
            console.log('got error', jqXHR);
          },
          success: function(data, status, jqXHR) {
            $form.remove();
            $el.find('.pitch-success-content').removeClass('hide');
          }
        });

      }
    });
  }

  window.Billion = window.Billion || {}
  Billion.PitchModal = PitchModal;
}());
