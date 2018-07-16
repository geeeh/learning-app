# frozen_string_literal: true

configure :test do
  ActiveRecord::Base.establish_connection(
    adapter: postgresql,
    database: tests
  )
end
