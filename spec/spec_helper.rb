# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sinatra'

ENV['RACK_ENV'] = 'test'

require './app/controllers/auth_controller.rb'
require './app/controllers/base_controller.rb'
require 'simplecov'

SimpleCov.start

class All < Sinatra::Application
  use BaseController
  use AuthController
end

module RSpecMixin
  include Rack::Test::Methods
  def app
    All
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

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
