# frozen_string_literal: true

describe 'Micro Learning Application' do
  before do
    @test_user = {
      username: 'test_user',
      email: 'test.user@gmail.com',
      password: '123123123'
    }
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
      @test_login_user = {
        email: 'test.user@gmail.com',
        password: '123123123'
      }

      post '/login', @test_login_user
    end
    it 'should be redirect access topics page' do
      get '/topics'
      expect(last_request.path).to eq('/topics')
    end
  end
end
