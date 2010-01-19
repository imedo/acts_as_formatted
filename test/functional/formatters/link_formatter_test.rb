require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class LinkFormatterTest < ActiveSupport::TestCase
  def setup
    @formatter = LinkFormatter.new(nil)
  end
  
  test "should link http urls" do
    assert_equal "<a href=\"http://www.example.com\">http://www.example.com</a>", @formatter.format_text('http://www.example.com')
  end
  
  test "should link email addresses" do
    assert_equal "<a href=\"mailto:john.doe@example.com\">john.doe@example.com</a>", @formatter.format_text('john.doe@example.com')
  end
end
