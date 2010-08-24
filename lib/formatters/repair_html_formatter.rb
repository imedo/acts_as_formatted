require 'hpricot'

class RepairHtmlFormatter
  def format_text(text)
    Hpricot(text).inner_html
  end
end
