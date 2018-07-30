# frozen_string_literal: true

require_relative '../spec_helper.rb'
require './app/models/user'

describe User do
  let!(:invalid_user) do
    User.new
  end

  let!(:valid_user) do
    User.new(username: 'test_name', email: 'test_name@gmail.com', password: '123123123')
  end
  context 'with a valid user' do
    it 'should validate presence of email' do
      expect(invalid_user).to be_invalid
    end
  end
  context 'with a valid user' do
    it 'should create user successfully' do
      expect(valid_user).to be_valid
    end
  end
end
