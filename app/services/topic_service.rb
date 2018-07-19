# frozen_string_literal: true

require './app/clients/news_api'

# Topic service
class TopicService
  def fetch_articles(choices)
    news_api = NewsApiClient.new
    query_topics = choices.join(', ')
    @articles = news_api.fetch_stories(query_topics)
  end
end
