# frozen_string_literal: true

require 'news-api'

# News Api client
class NewsApiClient
  def initialize(api_key = nil)
    @api_key = api_key || '802e4f6a5477493d9975957c95dfe76f'
    @news_api = News.new(@api_key)
  end

  def fetch_stories(preferred_topics)
    @articles = @news_api.get_everything(q: preferred_topics,
                                         sources: 'bbc-news,the-verge',
                                         domains: 'bbc.co.uk, techcrunch.com',
                                         language: 'en',
                                         page: 2)
  end
end
