require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'pry'

lib = File.expand_path('../spec', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

RSpec.configure do |config|

  config.before(:suite) do
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :database => ':memory:'
    })
    load File.dirname(__FILE__) + '/schema.rb'
    require "example_app"
  end

end
