require 'hpricot'

class RepairHtmlFormatter < BaseFormatter
  def format_text(text)
    Hpricot(text).inner_html
  end
end
