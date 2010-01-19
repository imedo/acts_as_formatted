require File.expand_path(File.dirname(__FILE__) + '/abstract_unit')

class ActiveSupport::TestCase
protected
  def reset_active_record_class(name)
    Object.send :remove_const, name if Object.const_defined?(name)
    Object.const_set(name, Class.new(ActiveRecord::Base))
  end
end
