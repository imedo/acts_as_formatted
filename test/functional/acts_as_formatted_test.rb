require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedTest < ActiveSupport::TestCase
  def setup
    reset_active_record_class :Article
  end
  
  test "should format text on save" do
    Article.acts_as_formatted :formatters => :noop
    article = Article.new(:text => 'Hello')
    assert_nil article.attributes['formatted_text']
    article.save
    
    assert_not_nil article.attributes['formatted_text']
    assert_equal article.text, article.formatted_text
  end
  
  test "should not automatically update formatted field on subsequent access" do
    Article.acts_as_formatted :formatters => :noop
    article = Article.new(:text => 'Hello', :formatted_text => 'Foo')
    assert_equal 'Foo', article.attributes['formatted_text']
    article.formatted_text
    assert_equal 'Foo', article.attributes['formatted_text']
  end
  
  test "should actually format content" do
    Article.acts_as_formatted :formatters => [ :simple, :link ]
    article = Article.new(:text => 'Hello http://www.example.com')
    article.update_formatted_content
    assert_equal "<p>Hello <a href=\"http://www.example.com\">http://www.example.com</a></p>", article.formatted_text
  end
  
  test "should save formatted content" do
    Article.acts_as_formatted :formatters => [ :simple ]
    article = Article.create(:text => 'Hello')
    assert_equal "<p>Hello</p>", article.reload.formatted_text
  end
end
