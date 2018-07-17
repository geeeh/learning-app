# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sinatra'

require './app/controllers/base_controller.rb'
require 'simplecov'

SimpleCov.start

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    App
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
