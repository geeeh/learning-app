# frozen_string_literal: true

require 'sinatra'
require './app/models/category.rb'
require './app/models/user.rb'

# SubjectController class.
class App < Sinatra::Application
  get_categories = lambda do
    unless session[:id]
      flash[:notice] = 'please login!'
      redirect '/login'
    end
    @categories = Subject.all
    @user = User.find_by(id: session[:id])
    @user_categories = @user.subjects.all

    haml :categories
  end

  add_categories_page = lambda do
    haml :addcategory
  end

  add_categories = lambda do
    @user = User.find_by(id: session[:id])
    p params
    params['choice'].each do |item|
      user_categories = @user.subjects.find_by(id: item)
      if user_categories
        flash[:notice] = 'you already have this category'
        redirect '/categories'
      end
      category = Subject.find_by(id: item)
      @user.subjects << category
      @user.save
    end
    redirect '/categories'
  end

  create_subject = lambda do
    @category = Subject.create(name: params['name'], description: params['description'])
    unless @category.errors.messages.empty?
      flash[:notice] = 'this category already exists!'
      redirect '/addcategories'
    end
    redirect '/categories'
  end

  delete_subject = lambda do
    @subject = Subject.find_by(id: params[:id])
    @subject.delete
  end

  get '/categories', &get_categories
  get '/addcategories', &add_categories_page
  post '/categories', &create_subject
  post '/categories/add', &add_categories
  delete '/categories/:id', &delete_subject
end
