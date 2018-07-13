# frozen_string_literal: true

# SubjectController class.
class SubjectController < BaseController
  get_categories = lambda do
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
    params['choice'].each do |item|
      category = Subject.find_by(id: item)
      @user.subjects << category
      @user.save
    end
    redirect '/categories'
  end

  create_subject = lambda do
    Subject.create(name: params['name'], description: params['description'])
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
