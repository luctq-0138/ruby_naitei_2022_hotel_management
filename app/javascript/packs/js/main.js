$(document).on('turbolinks:load', function () {
  $('.loader').fadeOut();
  $('#preloder').delay(200).fadeOut('slow');
});
$(document).on('turbolinks:load', function () {
  ('use strict');
  /*------------------
        Preloader
    --------------------*/
  $(window).on('load', function () {});

  jQuery(function ($) {
    /*------------------
        Background Set
    --------------------*/
    $('.set-bg').each(function () {
      var bg = $(this).data('setbg');
      $(this).css('background-image', 'url(' + bg + ')');
    });

    //Offcanvas Menu
    $('.canvas-open').on('click', function () {
      $('.offcanvas-menu-wrapper').addClass('show-offcanvas-menu-wrapper');
      $('.offcanvas-menu-overlay').addClass('active');
    });

    $('.canvas-close, .offcanvas-menu-overlay').on('click', function () {
      $('.offcanvas-menu-wrapper').removeClass('show-offcanvas-menu-wrapper');
      $('.offcanvas-menu-overlay').removeClass('active');
    });

    // Search model
    $('.search-switch').on('click', function () {
      $('.search-model').fadeIn(400);
    });

    $('.search-close-switch').on('click', function () {
      $('.search-model').fadeOut(400, function () {
        $('#search-input').val('');
      });
    });

    /*------------------
		Navigation
	--------------------*/
    $('.mobile-menu').slicknav({
      prependTo: '#mobile-menu-wrap',
      allowParentLinks: true,
    });

    /*------------------
        Hero Slider
    --------------------*/
    $('.hero-slider').owlCarousel({
      loop: true,
      margin: 0,
      items: 1,
      dots: true,
      animateOut: 'fadeOut',
      animateIn: 'fadeIn',
      smartSpeed: 1200,
      autoHeight: false,
      autoplay: true,
      mouseDrag: false,
    });

    /*------------------------
		Testimonial Slider
    ----------------------- */
    $('.testimonial-slider').owlCarousel({
      items: 1,
      dots: false,
      autoplay: true,
      loop: true,
      smartSpeed: 1200,
      nav: true,
      navText: ["<i class='arrow_left'></i>", "<i class='arrow_right'></i>"],
    });

    /*------------------
        Magnific Popup
    --------------------*/
    $('.video-popup').magnificPopup({
      type: 'iframe',
    });

    /*------------------
		Date Picker
	--------------------*/
    $('#booking_date_in').datepicker({
      minDate: '0',
      dateFormat: 'yy/mm/dd',
      onSelect: function (dateStr) {
        var min = $(this).datepicker('getDate');
        if (min) {
          min.setDate(min.getDate() + 1);
        }
        $('#booking_date_out').datepicker('option', 'minDate', min || '0');
      },
    });

    $('#booking_date_out').datepicker({
      minDate: '0',
      dateFormat: 'yy/mm/dd',
      onSelect: function (dateStr) {
        var max = $(this).datepicker('getDate');
        if (max) {
          max.setDate(max.getDate() - 1);
        }
        $('#booking_date_in').datepicker('option', 'maxDate', max || '+1Y+6M');
      },
    });

    $('#room_type_date_in').datepicker({
      minDate: '0',
      dateFormat: 'yy/mm/dd',
      onSelect: function (dateStr) {
        var min = $(this).datepicker('getDate');
        if (min) {
          min.setDate(min.getDate() + 1);
        }
        $('#room_type_date_out').datepicker('option', 'minDate', min || '0');
      },
    });

    $('#room_type_date_out').datepicker({
      minDate: '0',
      dateFormat: 'yy/mm/dd',
      onSelect: function (dateStr) {
        var max = $(this).datepicker('getDate');
        if (max) {
          max.setDate(max.getDate() - 1);
        }
        $('#room_type_date_in').datepicker(
          'option',
          'maxDate',
          max || '+1Y+6M'
        );
      },
    });
    /*------------------
		Nice Select
	--------------------*/
    $('select').niceSelect();
  });
});
