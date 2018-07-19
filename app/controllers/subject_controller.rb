# frozen_string_literal: true

require 'sinatra'
require './app/models/subject'
require './app/models/user'
require './app/middleware/authenticator'

# SubjectController class.
class App < Sinatra::Application
  get_categories = lambda do
    @categories = Subject.all
    @user_categories = @user.subjects.all
    haml :categories
  end

  add_categories_page = lambda do
    haml :addcategory
  end

  add_categories = lambda do
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
    redirect '/categories'
  end

  delete_subject = lambda do
    @subject = Subject.find_by(id: params[:id])
    @subject.delete
    redirect '/categories'
  end

  get '/categories', auth: true, &get_categories
  get '/addcategories', auth: true, &add_categories_page
  post '/categories', auth: true, &create_subject
  post '/categories/delete', auth: true, &delete_subject
  post '/categories/add', auth: true, &add_categories
  delete '/categories/:id', auth: true, &delete_subject
end
