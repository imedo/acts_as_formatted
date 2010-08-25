Gem::Specification.new do |s| 
  s.platform  =   Gem::Platform::RUBY
  s.name      =   "acts_as_formatted"
  s.version   =   "0.0.1"
  s.date      =   Date.today.strftime('%Y-%m-%d')
  s.author    =   "imedo GmbH"
  s.email     =   "entwickler@imedo.de"
  s.homepage  =   "http://www.imedo.de"
  s.summary   =   "Save processed version of a text in the database."
  s.files     =   Dir.glob("lib/**/*")
  s.require_path = "lib"
end
