# frozen_string_literal: true

require 'sinatra'
require 'pony'
require_relative '../clients/news_api'

# class TopicController
class App < Sinatra::Application
  def fetch_user_choices_by_id(user_id)
    choices = []
    user = User.find_by(id: user_id)
    p user.subjects.all.empty?
    redirect '/categories' if user.subjects.all.empty?
    user.subjects.all.each do |item|
      choices << item.name
    end
    choices
  end

  get_topics = lambda do
    news_api = NewsApiClient.new
    puts session[:id]
    unless session[:id]
      flash[:notice] = 'please login!'
      redirect '/login'
    end
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

  get '/topics', &get_topics
end
