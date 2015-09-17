(function() {
  $('a.social-share-icon').on('click', function(evt) {
    evt.preventDefault();
    var width = 500,
        height = 500,
        left = (screen.availWidth - width) / 2,
        top = 0;


    var strWindowFeatures = [
      'menubar=no',
      'location=no',
      'resizble=yes',
      'status=no',
      'width=' + width,
      'height=' + height,
      'top=' + top,
      'left=' + left
    ].join(',')

    window.open($(this).attr('href'), 'sharewindow', strWindowFeatures);
  });
}());
