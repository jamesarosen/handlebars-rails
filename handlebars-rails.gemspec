# my_rails_engine.gemspec
Gem::Specification.new do |gem|
  gem.version = '0.0.1'
  gem.name = 'handlebars-rails'
  gem.files = Dir["lib/**/*", "app/**/*", "config/**/*"] + %w(README.md HISTORY.md)
  gem.summary = "Rails Template Handler for Handlebars"
  gem.description = "Use Handlebars.js client- and server-side"
  gem.email = "james.a.rosen@gmail.com"
  gem.homepage = "http://github.com/jamesarosen/arturo"
  gem.authors = ["James A. Rosen", "Yehuda Katz"]
  gem.test_files = []
  gem.require_paths = [".", "lib"]
  gem.has_rdoc = 'false'
  current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
  gem.specification_version = 2
  gem.add_runtime_dependency      'rails',        '~> 3.0'
  gem.add_development_dependency  'mocha'
  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'redgreen',     '~> 1.2'
end
