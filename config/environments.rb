# frozen_string_literal: true

configure :development, :production do
  ActiveRecord::Base.establish_connection(
    adapter: ENV['ADAPTER'] || 'postgresql',
    host: ENV['HOST'] || 'localhost',
    username: ENV['USER'] || 'godwingitonga',
    password: ENV['PASSWORD'] || nil,
    database: ENV['DATABASE'] || 'micro-learning',
    encoding: ENV['ENCODING'] || 'utf8'
  )
end

configure :test do
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: 'tests',
    encoding: 'utf8'
  )
end
