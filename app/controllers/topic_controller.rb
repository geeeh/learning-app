# frozen_string_literal: true
require 'sinatra'
require 'news-api'
require 'pony'

# class TopicController
class App < Sinatra::Application
  newsapi = News.new('802e4f6a5477493d9975957c95dfe76f')

  def fetch_user_choices_by_id(user_id)
    choices = []
    @user = User.find_by(id: user_id)
    @user.subjects.all.each do |item|
      choices << item.name
    end
    choices
  end

  get_topics = lambda do
    puts session[:id]
    unless session[:id]
      flash[:notice] = 'please login!'
      redirect '/login'
    end
    choices = fetch_user_choices_by_id session[:id]
    query_topics = choices.join(', ')
    @articles = newsapi.get_everything(q: query_topics,
                                       sources: 'bbc-news,the-verge',
                                       domains: 'bbc.co.uk,techcrunch.com',
                                       language: 'en',
                                       page: 2)
    haml :topics
  end

  def send_emails(user_id)
    choices = get_user_choices_by_id user_id
    query_topics = choices.join(', ')
    @articles = newsapi.get_everything(q: query_topics, sources: 'bbc-news,the-verge', domains: 'bbc.co.uk,techcrunch.com', language: 'en', page: 1)
    Pony.mail(to: 'godwingitonga89@gmail.com',
              from: 'dev.godwin.gitonga@gmail.com',
              subject: 'Daily topics',
              body: render_to_string('./app/views/email.haml', locals: { articles: @articles }, layout: true))
  end

  get '/topics', &get_topics
end
