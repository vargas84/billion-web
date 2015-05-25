$(document).ready(function() {
  $('a').click(function(e) {
    var $a = $(e.currentTarget),
        href = $a.attr('href');

    if (href.length > 1 && href[0] === '#') {
      e.preventDefault();

      $('html, body').animate({
        scrollTop: $(href).offset().top
      }, 500);
    }
  });
});
