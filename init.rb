# Include hook code here
require 'acts_as_formatted'
require 'hash'

Dir.glob(File.dirname(__FILE__) + '/lib/formatters/*.rb').each do |formatter|
  require formatter
end

ActiveRecord::Base.send :include, ActsAsFormatted
