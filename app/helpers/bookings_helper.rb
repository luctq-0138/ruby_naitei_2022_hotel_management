module BookingsHelper
  def compact_text text
    "#{text[0..100]}..."
  end

  def check_status booking
    if booking.pending?
      content_tag(:span, "Chờ phê duyệt", class: "badge badge-secondary")
    elsif booking.approve?
      content_tag(:span, "Phê duyệt", class: "badge badge-success")
    elsif booking.refuse?
      content_tag(:span, "Từ chối bởi admin", class: "badge badge-danger")
    elsif booking.cancel?
      content_tag(:span, "Người dùng hủy booking", class: "badge badge-primary")
    elsif booking.paid?
      content_tag(:span, "Người dùng đã thanh toán", class: "badge badge-info")
    end
  end
end
