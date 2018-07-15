# frozen_string_literal: true

require './helpers/spec_helper.rb'

describe 'Micro Learning Application' do
  context 'when trying to access registration page' do
    it 'should be accessible' do
      get '/register'
      expect(last_response).to be_ok
    end

    it 'should lead to registration' do
      get '/register'
      expect(last_request.path).to eq('/register')
    end
  end

  context 'when passed correct registration data' do
    before do
      @test_user = {
        username: 'test_user',
        email: 'test.user@gmail.com',
        password: '123123123'
      }
    end

    it 'should redirect to login' do
      post '/register', @test_user
      expect(last_request.path).to eq('/login')
    end
  end

  context 'when passed incorrect registration data' do
    before do
      @test_user = {
        username: 'test_user',
        email: 'test',
        password: '123123123'
      }
    end

    it 'should redirect to login' do
      post '/register', @test_user
      expect(last_request.path).to eq('/register')
    end
  end

  context 'when passed already existing email' do
    before do
      @user = {
        username: 'test_user',
        email: 'test@gmail.com',
        password: '123123123'
      }
      post '/register', @user
    end
    it 'should redirect back to register with a flash message' do
      post '/register', @user
      expect(last_response).to be_redirect
      expect(last_request.path).to eq('/register')
    end
  end
end
