# frozen_string_literal: true

require_relative '../spec_helper.rb'

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

  context 'when trying to access login page' do
    it 'should be accessible' do
      get '/login'
      expect(last_response).to be_ok
    end

    it 'should lead to registration' do
      get '/login'
      expect(last_request.path).to eq('/login')
    end
  end

  context 'when passed correct registration data' do
    before do
      @test_user = {
        username: 'test',
        email: 'test.user@gmail.com',
        password: '1231231234'
      }
    end

    it 'should redirect to login' do
      post '/register', @test_user
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'when passed correct login data' do
    it 'should redirect to daily topics page' do
      test_user_login = {
        email: 'admin@gmail.com',
        password: '123454321'
      }

      post '/login', test_user_login
      follow_redirect!
      expect(last_request.path).to eq('/topics')
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

    it 'should redirect to register' do
      post '/register', @test_user
      expect(last_request.path).to eq('/register')
    end
  end

  context 'when passed already existing email' do
    before do
      @user = {
        username: 'test_user',
        email: 'admin@gmail.com',
        password: '123123123'
      }
      post '/register', @user
    end
    it 'should redirect back to register with a flash message' do
      post '/register', @user
      follow_redirect!
      expect(last_response.body).to include('has already been taken')
    end
  end

  context 'when passed already existing username' do
    it 'should redirect back to register with a flash message' do
      current_user = {
        username: 'Admin',
        email: 'newadmin@gmail.com',
        password: '123454321'
      }
      post '/register', current_user
      follow_redirect!
      expect(last_response.body).to include('has already been taken')
    end
  end
end
