# frozen_string_literal: true

Dir.glob('./app/models/*.rb').sort.each do |file|
  require file
end
Dir.glob('./app/controllers/*.rb').sort.each do |file|
  require file
end

require './app/scheduler/scheduler.rb'

use AuthController
use SubjectController
use TopicController

map '/' do
  run BaseController
end
