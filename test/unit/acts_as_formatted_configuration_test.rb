require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedConfigurationTest < ActiveSupport::TestCase
  def setup
    ActsAsFormatted.default_options = {
      :fields => :text,
      :formatters => :simple
    }
  end
  
  test "should allow different configuration forms" do
    expected = { :text => { :formatters => [ :simple ], :formatted_field => :formatted_text } }

    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, {                                                        })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => :text                                       })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text ]                                   })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => :simple }                        })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => [ :simple ] }                    })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => { :formatters => :simple } }     })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => { :formatters => [ :simple ] } } })
  end
  
  test "should allow to configure multiple fields" do
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text, :summary ] })
  end
  
  test "should allow to configure multiple fields with different formatters" do
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple, :complicated ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text, { :summary => [ :simple, :complicated ] }] })
  end
  
  test "should allow to override formatters for all fields" do
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple, :complicated ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple, :complicated ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :formatters => [ :simple, :complicated ], :fields => [ :text, :summary ] })
  end
end
