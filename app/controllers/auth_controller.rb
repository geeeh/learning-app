# frozen_string_literal: true

require './app/controllers/base_controller'
require 'bcrypt'

# Auth controller class.
class AuthController < BaseController
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
      begin
        flash[:notice] = 'wrong login credentials!'
        redirect '/login'
      end
    end
    result = @user.confirm_password(params['password'], @existing_user)
    if result
      session[:id] = @existing_user.id
      session[:username] = @existing_user.username
      redirect '/topics'
    else
      flash[:notice] = 'wrong login credentials!'
      redirect '/login'
    end
  end

  register_user = lambda do
    email = params['email']
    username = params['username']
    if User.find_by(email: email)
      flash[:notice] = 'Email Already taken!'
      redirect '/register'
    end

    if User.find_by(username: username)
      flash[:notice] = 'Username already taken!'
      redirect '/register'
    end
    @new_user = User.new(email: email, username: username)
    @new_user.encrypt_password params['password']
    @new_user.save
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
