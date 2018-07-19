# frozen_string_literal: true

require 'sendgrid-ruby'

# Class Mailer responsible for sending emails
class Mailer
  include SendGrid

  def compose_email(recipient_email)
    from = Email.new(email: 'godwingitonga89@gmail.com')
    to = Email.new(email: recipient_email)
    subject = 'Daily digest'
    content = Content.new(type: 'text/html', value: '
    <h4>We have new stories for you</h4>
    <p>visit our website for your daily digest.</p>
    <a href="https://g-learning-app.herokuapp.com/topics"> Daily Diget</a>
')
    @mail = Mail.new(from, subject, to, content)
  end

  def send_emails(email)
    mail = compose_email(email)
    sg = SendGrid::API.new(api_key: "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")
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
  end
end
