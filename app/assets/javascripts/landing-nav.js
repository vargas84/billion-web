(function() {
  'use strict';


  var $stickyNav = $('.navbar-sticky');
  var $nonStickyNav = $('.navbar-non-sticky');
  var $leftContainer = $('.navbar-left-container');

  var $jumbotronPlayBtn = $('.jumbotron-landing .play-btn');
  var threshold = $jumbotronPlayBtn.offset().top + $jumbotronPlayBtn.height();

  var isShowing = false;

  $stickyNav.addClass('animated');
  $leftContainer.addClass('animated');

  $(window).on('scroll', _.debounce(toggleLogo, 100));
  $(window).on('scroll', _.debounce(toggleSticky, 100));

  function toggleLogo() {
    var scrollTop = $(window).scrollTop();

    if (scrollTop > threshold) {
      $leftContainer.addClass('fadeIn');
    } else {
      $leftContainer.removeClass('fadeIn');
      $leftContainer.css({'opacity': 0});
    }
  }

  function toggleSticky() {
    if (!$nonStickyNav.is(':visible')) {
      return;
    }

    var scrollTop = $(window).scrollTop();

    if (scrollTop > threshold) {
      $stickyNav.removeClass('visible-xs');
      $stickyNav.addClass('slideInDown').removeClass('slideOutUp');
    } else {
      if (!$stickyNav.hasClass('visible-xs')) {
        $stickyNav.addClass('slideOutUp').removeClass('slideInDown');
        setTimeout(function() {
          $stickyNav.addClass('visible-xs');
        }, 500);
      }
    }

  }

}());
