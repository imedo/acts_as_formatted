# Include hook code here
require 'acts_as_formatted/timestamps'
require 'acts_as_formatted/acts_as_formatted'
require 'acts_as_formatted/hash'

Dir.glob(File.dirname(__FILE__) + '/acts_as_formatted//formatters/*.rb').sort.each do |formatter|
  require formatter
end

ActiveRecord::Base.send :include, ActsAsFormatted
