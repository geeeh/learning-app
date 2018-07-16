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
      expect(last_response).to be_ok
    end
  end
end
