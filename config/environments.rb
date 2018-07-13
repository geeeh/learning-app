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
