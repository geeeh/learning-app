# frozen_string_literal: true

Dir.glob('./app/models/*.rb').sort.each do |file|
  require file
end
Dir.glob('./app/controllers/*.rb').sort.each do |file|
  require file
end

require './app/scheduler/scheduler.rb'

map '/' do
  run App
end
