require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class SimpleFormatterTest < Test::Unit::TestCase
  def setup
    @formatter = SimpleFormatter.new(nil)
  end
  
  def test_should_add_paragraph_to_text
    assert_equal '<p>Text</p>', @formatter.format_text('Text')
  end
  
  def test_should_add_break_tags
    assert_equal "<p>More\n<br />Text</p>", @formatter.format_text("More\nText")
  end
  
  def test_should_break_paragraph_on_subsequent_line_breaks
    assert_equal "<p>More</p>\n\n<p>Text</p>", @formatter.format_text("More\n\nText")
  end
end
