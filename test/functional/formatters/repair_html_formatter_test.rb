require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RepairHtmlFormatterTest < ActiveSupport::TestCase
  def setup
    @formatter = RepairHtmlFormatter.new
  end
  
  test "should not touch wellformed html" do
    assert_equal '<p>Text</p>', @formatter.format_text('<p>Text</p>')
  end
  
  test "should not touch plain text" do
    assert_equal 'Text', @formatter.format_text('Text')
  end
  
  test "should not touch plain text outside html" do
    assert_equal 'Text <p>More text</p>', @formatter.format_text('Text <p>More text</p>')
  end
  
  test "should close tags" do
    assert_equal '<p><a>Link</a><a>another link</a></p>', @formatter.format_text('<p><a>Link<a>another link</p>')
  end
  
  test "should correct wrong closing tag" do
    assert_equal '<p><a>Link</a></p>', @formatter.format_text('<p><a>Link</b></p>')
  end
  
  test "should remove excessive closing tag" do
    assert_equal '<p><a>Link</a></p>', @formatter.format_text('<p><a>Link</a></a></p>')
  end
end
