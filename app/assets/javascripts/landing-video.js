$(function () {
  var $modalVideo = $('#modalVideo'),
      $videoIframe = $('#embedVideo').find('iframe'),
      videoSrc = $videoIframe.attr('src');

  $modalVideo.on('hidden.bs.modal', function (e) {
    $videoIframe.attr('src', '');
    $videoIframe.attr('src', videoSrc);
  });
});
