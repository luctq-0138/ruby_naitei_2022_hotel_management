window.roomSelect = function (self) {
  room_id = $(self).prev().html();
  $('#list_rooms').removeClass('display');
  if ($(self).hasClass('grid-item-selected')) {
    $(self).removeClass('grid-item-selected');
    let room_remove = '@' + room_id;
    let remain_room = $('#booking_input_rooms').val().replace(room_remove, '');
    $('#booking_input_rooms').val(remain_room);
  } else {
    $(self).addClass('grid-item-selected');
    $('#booking_input_rooms').val(function (index, oldVal) {
      return oldVal + '@' + room_id;
    });
  }
};

window.validate = function () {
  let rooms = $('.grid-item-selected').length;
  let date_in = $('#booking_date_in').val();
  let date_out = $('#booking_date_out').val();
  let flag_error = false;
  if (rooms == 0) {
    flag_error = true;
    $('#list_rooms').addClass('display');
  }
  if (!date_in) {
    flag_error = true;
    $('#date_in').addClass('display');
  }
  if (!date_out) {
    flag_error = true;
    $('#date_out').addClass('display');
  }
  if (flag_error) {
    return false;
  }
  return true;
};
window.validateSearchRoomType = function () {
  let rooms = $('.grid-item-selected').length;
  let date_in = $('#room_type_date_in').val();
  let date_out = $('#room_type_date_out').val();
  let flag_error = false;
  if (rooms == 0) {
    flag_error = true;
    $('#list_rooms').addClass('display');
  }
  if (!date_in) {
    flag_error = true;
    $('#date_in').addClass('display');
  }
  if (!date_out) {
    flag_error = true;
    $('#date_out').addClass('display');
  }
  if (flag_error) {
    return false;
  }
  return true;
};
