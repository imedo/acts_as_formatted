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
  
  test "should update all formatted content with timestamps" do
    original_timestamp = 2.days.ago
    article = Article.create(:text => 'Hello', :created_at => original_timestamp, :updated_at => original_timestamp)
    article.save
    assert_equal original_timestamp.to_s(:db), article.reload.updated_at.to_s(:db)
    
    Article.acts_as_formatted :formatters => [ :simple ]
    assert_equal nil, article.attributes['formatted_text']
    
    Article.update_all_formatted_content!(true)
    assert_equal "<p>Hello</p>", article.reload.formatted_text
    assert_not_equal original_timestamp.to_s(:db), article.reload.updated_at.to_s(:db)
  end
  
  test "should update all formatted content without timestamps" do
    original_timestamp = 2.days.ago
    article = Article.create(:text => 'Hello', :created_at => original_timestamp, :updated_at => original_timestamp)
    article.save
    assert_equal original_timestamp.to_s(:db), article.reload.updated_at.to_s(:db)
    
    Article.acts_as_formatted :formatters => [ :simple ]
    assert_equal nil, article.attributes['formatted_text']
    
    Article.update_all_formatted_content!(false)
    assert_equal "<p>Hello</p>", article.reload.formatted_text
    assert_equal original_timestamp.to_s(:db), article.reload.updated_at.to_s(:db)
    
  end
  
end
