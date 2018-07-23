# frozen_string_literal: true

require 'sinatra'

require './app/models/category'
require './app/models/user'
require './app/middleware/authenticator'

# SubjectController class.
class App < Sinatra::Application
  before ['/categories', '/addcategories', '/categories/*'] do
    authenticate
  end

  get '/categories' do
    @categories = Category.all
    @user_categories = @user.categories
    haml :categories
  end

  get '/addcategories' do
    haml :addcategory
  end

  post '/categories/add' do
    params['choice'].each do |item|
      user_categories = @user.categories.find_by(id: item)
      if user_categories
        flash[:notice] = 'you already have this category'
        redirect '/categories'
      end
      category = Category.find_by(id: item)
      @user.categories << category
      @user.save
    end
    redirect '/categories'
  end

  post '/categories' do
    @category = Category.create(name: params['name'], description: params['description'])
    unless @category.errors.messages.empty?
      flash[:notice] = 'this category already exists!'
      redirect '/addcategories'
    end
    redirect '/categories'
  end

  # delete '/categories/:id' do
  #   @subject = Category.find_by(id: params[:id])
  #   @subject.delete
  #   redirect '/categories'
  # end

  delete '/categories/:id' do
    category = @user.categories.find_by_id(params[:id])
    @user.categories.delete(category) if category
    redirect '/categories'
  end
end
