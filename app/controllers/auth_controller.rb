# frozen_string_literal: true

require 'sinatra'
require 'bcrypt'
require './app/controllers/base_controller'
require './app/models/user'

# Auth controller class.
class App < Sinatra::Application
  login_user_page = lambda do
    haml :index
  end

  register_user_page = lambda do
    haml :register
  end

  login_user = lambda do
    @user = User.new
    @existing_user = User.find_by(email: params['email'])
    unless @existing_user
      flash[:notice] = 'wrong login credentials!'
      redirect '/login'
    end
    result = @user.confirm_password(params['password'], @existing_user)
    if result
      session[:user_id] = @existing_user.id
      session[:username] = @existing_user.username
      session[:admin] = @existing_user.admin?
      redirect '/topics'
    else
      flash[:notice] = 'wrong login credentials!'
      redirect '/login'
    end
  end

  register_user = lambda do
    email = params['email']
    username = params['username']
    password = params['password']
    @new_user = User.create(email: email, username: username, password: password)
    unless @new_user.valid?
      @new_user.errors.messages.each do |key, value|
        flash[key] = value.join(',') unless value.empty?
      end
      redirect '/register'
    end
    redirect '/login'
  end

  logout_user = lambda do
    session[:user_id] = nil
    redirect '/'
  end

  get '/login', &login_user_page
  get '/register', &register_user_page
  post '/login', &login_user
  post '/register', &register_user
  get '/logout', &logout_user
end
