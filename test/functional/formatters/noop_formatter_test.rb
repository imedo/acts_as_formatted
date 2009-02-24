require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NoopFormatterTest < Test::Unit::TestCase
  def test_should_not_change_text_on_formatting
    formatter = NoopFormatter.new(nil)
    assert_equal 'Text', formatter.format_text('Text')
  end
end
