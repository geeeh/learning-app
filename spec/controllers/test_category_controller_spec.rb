# frozen_string_literal: true

require_relative '../spec_helper.rb'
describe 'Micro Learning Application' do
  before do
    @test_user = {
      username: 'test_user',
      email: 'test.user@gmail.com',
      password: '123123123'
    }

    post 'register', @test_user
  end
  context 'when trying to access categories page without logging in' do
    it 'should be redirect to login' do
      get '/categories'
      expect(last_response).to be_redirect
    end
  end

  context 'when trying to access categories page when logged in' do
    before do
      @test_login_user = {
        email: 'test.user@gmail.com',
        password: '123123123'
      }

      post 'login', @test_login_user
    end
    it 'should be redirect access categories page' do
      get '/categories'
      expect(last_request.path).to eq('/categories')
    end
  end

  context 'when trying to create a new category when logged in' do
    before do
      @test_login_user = {
        email: 'test.user@gmail.com',
        password: '123123123'
      }

      @category = {
        name: 'music',
        description: 'stories about music'
      }

      post 'login', @test_login_user
    end
    it 'should be redirect access categories page' do
      post '/categories', @category
      expect(last_request.path).to eq('/categories')
    end
  end

  context 'when trying to add a new category as a user' do
    before do
      @test_login_user = {
        email: 'test.user@gmail.com',
        password: '123123123'
      }

      @category = {
        name: 'music',
        description: 'stories about music'
      }
      post 'login', @test_login_user
      post '/categories', @category
    end
    it 'should be redirect to categories page' do
      post '/categories', @category
      follow_redirect!
      expect(last_request.path).to eq('/addcategories')
      expect(last_response.body).to include('this category already exists!')
    end
  end
end
