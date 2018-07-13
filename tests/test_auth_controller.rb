# frozen_string_literal: true

require './helpers/spec_helper.rb'

describe 'Micro Learning Application' do
  context 'when passed correct registration data' do
    before do
      @test_user = {
        username: 'test_user',
        email: 'test.user@gmail.com',
        password: '123123123'
      }

      @headers = {
        'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
        'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
      }
    end

    it 'should redirect to login' do
      post '/register', @test_user, @headers
      expect(last_response).to be_redirect
    end
  end

  context 'when passed incorrect registration data' do
    before do
      @test_user = {
        username: 'test_user',
        email: 'test',
        password: '123123123'
      }

      @headers = {
        'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
        'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
      }
    end

    it 'should redirect to login' do
      post '/register', @test_user, @headers
      expect(last_response).to be_redirect
    end
  end
end
