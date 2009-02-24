require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class LinkFormatterTest < Test::Unit::TestCase
  def setup
    @formatter = LinkFormatter.new(nil)
  end
  
  def test_should_link_http_urls
    assert_equal "<a href=\"http://www.example.com\">http://www.example.com</a>", @formatter.format_text('http://www.example.com')
  end
  
  def test_should_link_email_addresses
    assert_equal "<a href=\"mailto:john.doe@example.com\">john.doe@example.com</a>", @formatter.format_text('john.doe@example.com')
  end
end
