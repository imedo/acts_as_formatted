require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NoopFormatterTest < ActiveSupport::TestCase
  test "should not change text on formatting" do
    formatter = NoopFormatter.new(nil)
    assert_equal 'Text', formatter.format_text('Text')
  end
end
