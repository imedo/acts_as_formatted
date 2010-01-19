require 'rubygems'

require 'dry_plugin_test_helper'

PluginTestEnvironment.initialize_environment(File.dirname(__FILE__), :rails_version => '2.3.3')

require 'mocha'
