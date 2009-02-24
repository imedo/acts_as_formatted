class LinkFormatter < BaseFormatter
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  def format_text(text)
    auto_link(text)
  end
end
