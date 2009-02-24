require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedTest < Test::Unit::TestCase
  def setup
    reset_active_record_class :Article
  end
  
  def test_should_format_text_on_save
    Article.acts_as_formatted :formatters => :noop
    article = Article.new(:text => 'Hello')
    assert_nil article.attributes['formatted_text']
    article.save
    
    assert_not_nil article.attributes['formatted_text']
    assert_equal article.text, article.formatted_text
  end
  
  def test_should_not_automatically_update_formatted_field_on_subsequent_access
    Article.acts_as_formatted :formatters => :noop
    article = Article.new(:text => 'Hello', :formatted_text => 'Foo')
    assert_equal 'Foo', article.attributes['formatted_text']
    article.formatted_text
    assert_equal 'Foo', article.attributes['formatted_text']
  end
  
  def test_should_actually_format_content
    Article.acts_as_formatted :formatters => [ :simple, :link ]
    article = Article.new(:text => 'Hello http://www.example.com')
    article.update_formatted_content
    assert_equal "<p>Hello <a href=\"http://www.example.com\">http://www.example.com</a></p>", article.formatted_text
  end
  
  def test_should_save_formatted_content
    Article.acts_as_formatted :formatters => [ :simple ]
    article = Article.create(:text => 'Hello')
    assert_equal "<p>Hello</p>", article.reload.formatted_text
  end
end
