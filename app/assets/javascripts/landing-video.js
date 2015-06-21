$(function () {
  var $modalVideo = $('#modalVideo'),
      $videoIframe = $('#embedVideo').find('iframe'),
      videoSrc = $videoIframe.attr('src');

  $modalVideo.on('hidden.bs.modal', function (e) {
    $videoIframe.attr('src', '');
    $videoIframe.attr('src', videoSrc);
  });

  $('.jumbotron .play-btn').on('click', function() {
    ga('send', 'event', 'landing_video', 'click', 'jumbotron');
  });

  $('.navbar-landing .play-btn').on('click', function() {
    ga('send', 'event', 'landing_video', 'click', 'navbar');
  });
});
