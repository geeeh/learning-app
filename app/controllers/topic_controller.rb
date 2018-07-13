# frozen_string_literal: true

require 'news-api'

# class TopicController
class TopicController < BaseController
  newsapi = News.new('802e4f6a5477493d9975957c95dfe76f')

  def fetch_categories
    choices = []
    @user = User.find_by(id: session[:id])
    @user.subjects.all.each do |item|
      choices << item.name
    end
    choices
  end

  get_topics = lambda do
    query_topics = fetch_categories.join(', ')
    @articles = newsapi.get_everything(q: query_topics, sources: 'bbc-news,the-verge', domains: 'bbc.co.uk,techcrunch.com', language: 'en',  page: 2)
    haml :topics
  end

  get '/topics', &get_topics
end
