# frozen_string_literal: true

require_relative '../spec_helper.rb'
require './app/models/category'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many :users }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { should validate_length_of(:name).is_at_least(2) }
  it { should validate_length_of(:description).is_at_least(2) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_length_of(:description).is_at_most(255) }
end
