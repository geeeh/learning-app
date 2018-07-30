# frozen_string_literal: true

require_relative '../spec_helper.rb'
require './app/models/category'

describe Category do
  let!(:category) do
    Category.new
  end

  let!(:valid_category) do
    Category.new(name: 'test_name', description: 'test description')
  end
  it 'should validates_presence_of :name' do
    expect(category).to be_invalid
    expect(valid_category).to be_valid
  end
end
