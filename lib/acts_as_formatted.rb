module ActsAsFormatted
  mattr_accessor :default_options
  self.default_options = {
    :fields => :text,
    :formatters => :simple
  }
  
  module ActsMethods
    def acts_as_formatted(options = {})
      return if acts_as_formatted?
      
      initialize_format_configuration
      set_format_configuration(options)
      
      define_format_hooks
      extend_class_for_acts_as_formatted
    end
    
    def acts_as_formatted?
      self.included_modules.include?(ActsAsFormatted::InstanceMethods)
    end
  
  private
    def initialize_format_configuration
      cattr_accessor :format_configuration
      self.format_configuration = {}
    end
    
    def set_format_configuration(options)
      self.format_configuration[:fields] = normalized_format_configuration(options)
    end
    
    def normalized_format_configuration(options)
      config_options = ActsAsFormatted.default_options.merge(options)
      fields = convert_fields_option_to_array(config_options[:fields])
      [fields].flatten.inject({}) do |hash, field|
        key, value = normalized_format_configuration_for(field, config_options)
        hash[key] = value
        hash
      end
    end
    
    def normalized_format_configuration_for(field, options)
      field_name = field.is_a?(Hash) ? field.keys.first.to_sym : field.to_sym
      field_options = field.is_a?(Hash) ? field[field_name] : (ActsAsFormatted.default_options.merge(options)).without(:fields)
      formatters = field_options.is_a?(Hash) ? field_options[:formatters] : field_options
      formatters ||= options[:formatters]
      formatters = [formatters].flatten
      
      return field_name, {
        :formatters => formatters,
        :formatted_field => options[:formatted_field] || :"formatted_#{field_name}"
      }
    end
    
    def convert_fields_option_to_array(option)
      if option.is_a?(Hash)
        option.collect { |key, value| { key => value } }
      else
        option
      end
    end
    
    def define_format_field_methods
      self.format_configuration[:fields].each do |key, value|
        define_format_field_methods_for(key, value[:formatted_field])
      end
    end
    
    def define_format_hooks
      self.before_save :update_formatted_content
    end
    
    def extend_class_for_acts_as_formatted
      self.extend         ActsAsFormatted::ClassMethods
      self.send :include, ActsAsFormatted::InstanceMethods
    end
  end

  module ClassMethods
  end
  
  module InstanceMethods
    def formatters_for(field_name)
      @formatters ||= {}
      @formatters[field_name] ||= begin
        formatters = self.class.format_configuration[:fields][field_name][:formatters]
        formatters.collect { |formatter| "#{formatter}_formatter".camelize.constantize.new }
      end
    end
    
    def reformat(field_name)
      text = attributes[field_name.to_s]
      formatters_for(field_name).each do |formatter|
        text = formatter.format_text(text)
      end unless text.nil?
      text
    end
    
    def update_formatted_content
      self.class.format_configuration[:fields].each do |field_name, field_options|
        send(:"#{field_options[:formatted_field]}=", reformat(field_name))
      end
    end
    
    def update_formatted_content!
      update_formatted_content
      save
    end
  end
  
  def self.included(receiver)
    receiver.extend(ActsAsFormatted::ActsMethods)
  end
end
