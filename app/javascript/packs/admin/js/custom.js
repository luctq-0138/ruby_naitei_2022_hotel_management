$(document).on('turbolinks:load', function () {
  jQuery(function ($) {
    $('.dropdown-toggle').on('click', function () {
      if ($('.dropdown-menu-filter').hasClass('show')) {
        $('.dropdown-menu-filter').removeClass('show');
      } else {
        $('.dropdown-menu-filter').addClass('show');
      }
    });
    $('#booking-date').datepicker({
      dateFormat: 'yy-mm-dd',
    });
    $('form').on('keypress', (e) => {
      if (e.keyCode == 13) {
        return false;
      }
    });
    $(document).ready(function () {
      $('.tags-input').tagsInput();
    });
  });
});
