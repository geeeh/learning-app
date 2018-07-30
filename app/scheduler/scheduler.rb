# frozen_string_literal: true

require 'rufus-scheduler'
require './app/controllers/topic_controller'

scheduler = Rufus::Scheduler.new

scheduler.cron '1 6 * * *' do
  send_multiple_emails
end

def send_multiple_emails
  @users = User.all
  @users.each do |user|
    @topic_controller.send_emails(user.email)
  end
end
