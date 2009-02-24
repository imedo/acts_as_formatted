require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class ActsAsFormattedConfigurationTest < Test::Unit::TestCase
  def setup
    ActsAsFormatted.default_options = {
      :fields => :text,
      :formatters => :simple
    }
  end
  
  def test_should_allow_different_configuration_forms
    expected = { :text => { :formatters => [ :simple ], :formatted_field => :formatted_text } }

    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, {                                                        })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => :text                                       })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text ]                                   })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => :simple }                        })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => [ :simple ] }                    })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => { :formatters => :simple } }     })
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => { :text => { :formatters => [ :simple ] } } })
  end
  
  def test_should_allow_to_configure_multiple_fields
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text, :summary ] })
  end
  
  def test_should_allow_to_configure_multiple_fields_with_different_formatters
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple, :complicated ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :fields => [ :text, { :summary => [ :simple, :complicated ] }] })
  end
  
  def test_should_allow_to_override_formatters_for_all_fields
    expected = {
      :text => { :formatted_field => :formatted_text, :formatters => [ :simple, :complicated ] },
      :summary => { :formatted_field => :formatted_summary, :formatters => [ :simple, :complicated ] }
    }
    
    assert_equal expected, ActiveRecord::Base.send(:normalized_format_configuration, { :formatters => [ :simple, :complicated ], :fields => [ :text, :summary ] })
  end
end
