require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'haml'

require './config/environments'

# Base controller for all other controllers.
class BaseController < Sinatra::Base
  register Sinatra::Flash

  configure do
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
    else
      flash[:notice] = 'please login!'
      redirect '/login'
    end
  end

  get '/', &landing
  get '/dashboard', &get_dashboard
end
