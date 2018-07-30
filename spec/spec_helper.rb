# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sinatra'

require './app/controllers/base_controller.rb'
require 'simplecov'
require 'coveralls'

Coveralls.wear!
SimpleCov.formatter = Coveralls::SimpleCov::Formatter

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
    load './db/seeds.rb'
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    DatabaseCleaner.start
    results = [{}]
    allow(NewsApiClient).to receive(:fetch_stories).and_return(results)
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
