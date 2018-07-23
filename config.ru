# frozen_string_literal: true
require 'dotenv/load'

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
