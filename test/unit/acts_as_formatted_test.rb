require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedTest < Test::Unit::TestCase
  def setup
    reset_active_record_class :Article
  end
  
  def test_should_set_configuration
    ActsAsFormatted.default_options = {
      :fields => :text,
      :formatters => :simple
    }

    expected = { :text => { :formatters => [ :simple ], :formatted_field => :formatted_text } }
    
    Article.acts_as_formatted
    assert_equal expected, Article.format_configuration[:fields]
  end
  
  def test_should_install_before_save_hook
    Article.expects(:before_save).with(:update_formatted_content)
    
    Article.acts_as_formatted
  end
  
  def test_should_include_and_extend_submodules
    Article.expects(:extend).with(ActsAsFormatted::ClassMethods)
    Article.expects(:include).with(ActsAsFormatted::InstanceMethods)
    
    Article.acts_as_formatted
  end
end
