# frozen_string_literal: true

require 'sinatra'
require 'pony'

require_relative '../clients/news_api'
require './app/middleware/authenticator'

# class TopicController
class App < Sinatra::Application
  def fetch_user_choices_by_id
    choices = []
    redirect '/categories' if @user.subjects.empty?
    @user.subjects.each do |item|
      choices << item.name
    end
    choices
  end

  get '/topics', auth: true do
    topic_service = TopicService.new
    choices = fetch_user_choices_by_id
    topic_service.fetch_articles(choices)
    haml :topics
  end
end
