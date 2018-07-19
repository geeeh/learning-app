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
    set :session_secret, '@31412drsvsgt!sdasdnjf34vb'
  end

  # Homepage
  landing = lambda do
    haml :index
  end

  get_dashboard = lambda do
    if session[:id]
      haml :dashboard
    end
  end

  get '/', &landing
  get '/dashboard', auth: true, &get_dashboard
end

require_relative 'auth_controller'
require_relative 'subject_controller'
require_relative 'topic_controller'
