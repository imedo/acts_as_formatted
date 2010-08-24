require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class SimpleFormatterTest < ActiveSupport::TestCase
  def setup
    @formatter = SimpleFormatter.new
  end
  
  test "should add paragraph to text" do
    assert_equal '<p>Text</p>', @formatter.format_text('Text')
  end
  
  test "should add break tags" do
    assert_equal "<p>More\n<br />Text</p>", @formatter.format_text("More\nText")
  end
  
  test "should break paragraph on subsequent line breaks" do
    assert_equal "<p>More</p>\n\n<p>Text</p>", @formatter.format_text("More\n\nText")
  end
end
