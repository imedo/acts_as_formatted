class LinkFormatter
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  
  def format_text(text)
    auto_link(text)
  end
end
