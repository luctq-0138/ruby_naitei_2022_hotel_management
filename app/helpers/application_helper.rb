module ApplicationHelper
  include Pagy::Frontend
  def error_message object, field
    message = object.errors[field].first if object.errors[field].present?
    content_tag(:div, message, class: "text-danger")
  end

  # rubocop:disable Rails/OutputSafety
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def is_active? link_path
    current_page?(link_path) ? "active" : ""
  end

  def store_search search
    session[:search] = search
  end
end
