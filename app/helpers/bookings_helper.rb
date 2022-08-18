module BookingsHelper
  def compact_text text
    "#{text[0..100]}..."
  end
end
