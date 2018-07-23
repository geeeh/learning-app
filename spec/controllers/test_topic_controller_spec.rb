# frozen_string_literal: true
require_relative '../spec_helper.rb'

describe 'Micro Learning Application' do
  let!(:test_user) do
    {
      email: 'admin@gmail.com',
      password: '123454321'
    }
  end

  before do
    post '/register', @test_user
  end

  context 'when trying to access daily topic page without logging in' do
    it 'should be redirect to login' do
      get '/topics'
      expect(last_response).to be_redirect
    end
  end

  context 'when trying to access daily topic page when logged in' do
    before do
      post '/login', test_user
    end
    it 'should be redirect access topics page' do
      get '/topics'
      expect(last_request.path).to eq('/topics')
    end
  end
end
