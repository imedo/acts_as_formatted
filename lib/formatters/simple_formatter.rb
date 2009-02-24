class SimpleFormatter < BaseFormatter
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  def format_text(text)
    simple_format(text)
  end
end
