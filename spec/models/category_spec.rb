# frozen_string_literal: true

require_relative '../spec_helper.rb'
require './app/models/category'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many :users }
  it { is_expected.to validate_presence_of :name }
end
