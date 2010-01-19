require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedTest < ActiveSupport::TestCase
  def setup
    reset_active_record_class :Article
  end
  
  test "should set configuration" do
    ActsAsFormatted.default_options = {
      :fields => :text,
      :formatters => :simple
    }

    expected = { :text => { :formatters => [ :simple ], :formatted_field => :formatted_text } }
    
    Article.acts_as_formatted
    assert_equal expected, Article.format_configuration[:fields]
  end
  
  test "should install before save hook" do
    Article.expects(:before_save).with(:update_formatted_content)
    
    Article.acts_as_formatted
  end
  
  test "should include and extend submodules" do
    Article.expects(:extend).with(ActsAsFormatted::ClassMethods)
    Article.expects(:include).with(ActsAsFormatted::InstanceMethods)
    
    Article.acts_as_formatted
  end
end
