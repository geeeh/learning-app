# frozen_string_literal: true

require 'sinatra'
require 'bcrypt'

require './app/controllers/base_controller'
require './app/models/user'

# Auth controller class.
class App < Sinatra::Application
  get '/login' do
    haml :index
  end

  get '/register' do
    haml :register
  end

  post '/login' do
    @existing_user = User.find_by(email: params['email'])
    unless @existing_user
      flash[:email] = 'Email not found!'
      redirect '/login'
    end
    result = @existing_user.authenticate(params['password'])
    if result
      session[:user_id] = @existing_user.id
      session[:username] = @existing_user.username
      session[:admin] = @existing_user.admin?
      redirect '/topics'
    else
      flash[:password] = 'wrong login credentials!'
      redirect '/login'
    end
  end

  post '/register' do
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

  get '/logout' do
    session[:user_id] = nil
    redirect '/'
  end
end
