# Include hook code here
require 'timestamps'
require 'acts_as_formatted'
require 'hash'

Dir.glob(File.dirname(__FILE__) + '/lib/formatters/*.rb').sort.each do |formatter|
  require formatter
end

ActiveRecord::Base.send :include, ActsAsFormatted
