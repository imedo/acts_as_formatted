require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RepairHtmlFormatterTest < Test::Unit::TestCase
  def setup
    @formatter = RepairHtmlFormatter.new(nil)
  end
  
  def test_should_not_touch_wellformed_html
    assert_equal '<p>Text</p>', @formatter.format_text('<p>Text</p>')
  end
  
  def test_should_not_touch_plain_text
    assert_equal 'Text', @formatter.format_text('Text')
  end
  
  def test_should_not_touch_plain_text_outside_html
    assert_equal 'Text <p>More text</p>', @formatter.format_text('Text <p>More text</p>')
  end
  
  def test_should_close_tags
    assert_equal '<p><a>Link</a><a>another link</a></p>', @formatter.format_text('<p><a>Link<a>another link</p>')
  end
  
  def test_should_correct_wrong_closing_tag
    assert_equal '<p><a>Link</a></p>', @formatter.format_text('<p><a>Link</b></p>')
  end
  
  def test_should_remove_excessive_closing_tag
    assert_equal '<p><a>Link</a></p>', @formatter.format_text('<p><a>Link</a></a></p>')
  end
end
