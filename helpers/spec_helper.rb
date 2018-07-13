require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require './app/controllers/auth_controller.rb'
require './app/controllers/base_controller.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app
    BaseController
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
