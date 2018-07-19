# frozen_string_literal: true

require 'sinatra'

require './app/models/subject'
require './app/models/user'
require './app/middleware/authenticator'

# SubjectController class.
class App < Sinatra::Application
  get '/categories', auth: true do
    @categories = Subject.all
    @user_categories = @user.subjects
    haml :categories
  end

  get '/addcategories', auth: true do
    haml :addcategory
  end

  post '/categories/add', auth: true do
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

  post '/categories', auth: true do
    @category = Subject.create(name: params['name'], description: params['description'])
    unless @category.errors.messages.empty?
      flash[:notice] = 'this category already exists!'
      redirect '/addcategories'
    end
    redirect '/categories'
  end

  delete '/categories/:id', auth: true do
    @subject = Subject.find_by(id: params[:id])
    @subject.delete
    redirect '/categories'
  end
end
