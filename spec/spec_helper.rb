ENV['RAILS_ENV'] = 'test'
require 'rubygems'
require 'bundler'
Bundler.setup
require 'minitest/spec'
require 'mocha'

require 'handlebars-rails'
require 'template'
require 'rails'
Rails.stubs(:root).returns File.dirname(__FILE__)

class MiniTest::Unit::TestCase
end

MiniTest::Unit.autorun
