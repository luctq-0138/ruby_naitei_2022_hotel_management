module ApplicationHelper
  include Pagy::Frontend
  def error_message object, field
    message = object.errors[field].first if object.errors[field].present?
    content_tag(:div, message, class: "text-danger")
  end
end
