# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'database_cleaner'
require 'sinatra'

require './app/controllers/base_controller.rb'
require 'simplecov'
require 'coveralls'
require 'factory_bot'
require 'shoulda/matchers'

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
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
    load './db/seeds.rb'
    FactoryBot.find_definitions
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
