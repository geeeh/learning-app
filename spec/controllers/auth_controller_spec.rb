# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe 'AuthController', type: :controller do
  let(:test_user) do
    { username: 'test',
      email: 'test.user@gmail.com',
      password: '1231231234' }
  end
  let!(:test_user_login) do
    {
      email: 'admin@gmail.com',
      password: '123454321'
    }
  end

  context 'when trying to access registration page' do
    it 'should be accessible' do
      get '/register'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Sign up')
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
    it 'should redirect to login' do
      post '/register', test_user
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'when passed correct login data' do
    it 'should redirect to daily topics page' do
      post '/login', test_user_login
      follow_redirect!
      expect(last_request.path).to eq('/topics')
    end
  end

  context 'when passed incorrect registration data' do
    let(:test_user) do
      {
        username: 'test_user',
        email: 'test',
        password: '123123123'
      }
    end
    it 'should redirect to register' do
      post '/register', test_user
      expect(last_request.path).to eq('/register')
    end
  end

  context 'when passed already existing email' do
    let(:test_user) do
      {
        username: 'Admin',
        email: 'admin@gmail.com',
        password: '123454321'
      }
    it 'should redirect back to register with a flash message' do
      end
      post '/register', test_user
      follow_redirect!
      expect(last_response.body).to include('provide a valid email!')
    end
  end

  context 'when passed already existing username' do
    let(:test_user) do
      {
        username: 'Admin',
        email: 'newadmin@gmail.com',
        password: '123454321'
      }
    end
    it 'should redirect back to register with a flash message' do
      post '/register', test_user
      follow_redirect!
      expect(last_response.body).to include('has already been taken')
    end
  end
end
