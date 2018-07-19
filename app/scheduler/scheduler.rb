# frozen_string_literal: true

require 'rufus-scheduler'
require './app/helpers/mailer'
require './app/services/topic_service'
require './app/models/user'

scheduler = Rufus::Scheduler.new

scheduler.cron '1 6 * * *' do
  send_multiple_emails
end

def send_multiple_emails
  mailer = Mailer.new
  topics = TopicService.new
  users = User.all
  users.each do |user|
    choices = fetch_user_choices(user)
    topics.fetch_articles(choices)
    mailer.send_emails(user.email)
  end
end

def fetch_user_choices(user)
  choices = []
  user.subjects.each do |item|
    choices << item.name
  end
  choices
end
