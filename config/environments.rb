# frozen_string_literal: true

configure :development, :production do
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: 'godwingitonga',
    password: nil,
    database: 'micro-learning',
    encoding: 'utf8'
  )
end

configure :test do
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: 'tests',
    encoding: 'utf8'
  )
end
