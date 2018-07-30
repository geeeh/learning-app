# frozen_string_literal: true

require 'sinatra'
require 'pony'

require_relative '../clients/news_api'
require './app/middleware/authenticator'
require './app/services/topic_service'

# class TopicController
class App < Sinatra::Application
  before '/topics' do
    authenticate
  end

  def fetch_user_choices_by_id
    choices = []
    redirect '/categories' if @user.categories.empty?
    @user.categories.each do |item|
      choices << item.name
    end
    choices
  end

  get '/topics' do
    topic_service = TopicService.new
    choices = fetch_user_choices_by_id
    @selected_categories = @user.categories
    @articles = topic_service.fetch_articles(choices)
    haml :topics
  end
end
