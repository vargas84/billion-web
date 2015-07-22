(function(window, $, ScrollMagic) {
  'use strict';

  window.Billion = window.Billion || {};

  window.Billion.LandingAnimator = function() {
    this.initialize = function() {
      this.cacheElems();
      this.initScrollController();
      this.setScrollScenes();
    };

    this.cacheElems = function() {
      this.$festivalStep1 = $('.festival-step:nth-of-type(1)');
      this.$festivalStep2 = $('.festival-step:nth-of-type(2)');
      this.$festivalStep3 = $('.festival-step:nth-of-type(3)');
      this.$pitchElems = $('.pitch-who, .pitch-why');
      this.$timelineEvents = $('.event-container');
      this.$festivalImg = $('.festival-img-lg');
    };

    this.initScrollController = function() {
      this.controller = new ScrollMagic.Controller();
    };

    this.setScrollScenes = function() {
      var self = this;

      var festivalTrigger1 = '.landing-festival .landing-section-heading p',
          festivalTrigger2 = '.festival-step:nth-of-type(1)',
          festivalTrigger3 = '.festival-step:nth-of-type(2)',
          pitchTrigger = '.landing-pitch .landing-section-heading',
          dateTrigger = '.landing-dates';

      new ScrollMagic.Scene({triggerElement: festivalTrigger1})
        .on('enter', function() {
          self.$festivalStep1.addClass('animated fadeInUp');
          self.$festivalImg.addClass('animated fadeInUp');
        }).addTo(this.controller);

      new ScrollMagic.Scene({triggerElement: festivalTrigger2})
        .on('enter', function() {
          self.$festivalStep2.addClass('animated fadeInUp');
        }).addTo(this.controller);

      new ScrollMagic.Scene({triggerElement: festivalTrigger3})
        .on('enter', function() {
          self.$festivalStep3.addClass('animated fadeInUp');
        }).addTo(this.controller);

      new ScrollMagic.Scene({triggerElement: pitchTrigger})
        .on('enter', function() {
          self.$pitchElems.addClass('animated fadeInUp');
        }).addTo(this.controller);

      new ScrollMagic.Scene({triggerElement: dateTrigger})
        .on('enter', function() {
          self.$timelineEvents.addClass('animated fadeInLeft');
        }).addTo(this.controller);
    };

    this.initialize();
  };
}(window, $, ScrollMagic));
