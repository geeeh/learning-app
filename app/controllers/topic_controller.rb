# frozen_string_literal: true

require 'sinatra'
require 'pony'
require_relative '../clients/news_api'
require './app/middleware/authenticator'

# class TopicController
class App < Sinatra::Application
  def fetch_user_choices_by_id(user_id)
    choices = []
    redirect '/categories' if @user.subjects.all.empty?
    @user.subjects.all.each do |item|
      choices << item.name
    end
    choices
  end

  get_topics = lambda do
    news_api = NewsApiClient.new
    choices = fetch_user_choices_by_id session[:id]
    query_topics = choices.join(', ')
    @articles = news_api.fetch_stories query_topics
    haml :topics
  end

  def send_emails(user_id)
    news_api = NewsApiClient.new
    choices = fetch_user_choices_by_id user_id
    query_topics = choices.join(', ')
    @articles = news_api.fetch_stories query_topics
    Pony.mail(to: 'godwingitonga89@gmail.com',
              from: 'dev.godwin.gitonga@gmail.com',
              subject: 'Daily topics',
              body: render_to_string('./app/views/email.haml',
                                     locals: { articles: @articles },
                                     layout: true))
  end

  def render_to_string(i, options)
    # code here
  end

  get '/topics', auth: true, &get_topics
end
