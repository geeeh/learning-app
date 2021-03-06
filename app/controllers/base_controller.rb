# frozen_string_literal: true

require 'sinatra'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'haml'

require './app/middleware/authenticator'

# Base controller for all other controllers.
class App < Sinatra::Application
  register Sinatra::Flash

  configure do
    set :environment, ENV['RACK_ENV']
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  # Homepage
  get '/' do
    haml :index
  end
end

require_relative 'auth_controller'
require_relative 'category_controller'
require_relative 'topic_controller'
