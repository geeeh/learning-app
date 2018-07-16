# frozen_string_literal: true

require 'rufus-scheduler'
require_relative '../controllers/topic_controller'

scheduler = Rufus::Scheduler.new
scheduler.cron '1 6 * * *' do
  send_multiple_emails
end

def send_multiple_emails
  @topic_controller = TopicController.new
  @users = User.all
  @users.foreach do |user|
    @topic_controller.send_emails user.id
  end
end
