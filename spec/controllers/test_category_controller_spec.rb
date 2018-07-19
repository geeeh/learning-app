# frozen_string_literal: true

require_relative '../spec_helper.rb'
describe 'Micro Learning Application' do
  context 'when trying to access categories page without logging in' do
    it 'should be redirect to login' do
      get '/categories'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end

  context 'when logged in' do
    before do
      @test_login_user = {
        email: 'admin@gmail.com',
        password: '123454321'
      }

      post 'login', @test_login_user
    end
    context 'and trying to access categories page' do
      it 'should be redirect access categories page' do
        get '/categories'
        expect(last_request.path).to eq('/categories')
      end
    end

    context 'and trying to create a new category' do
      it 'should be redirect access categories page' do
        category = {
          name: 'music',
          description: 'stories about music'
        }

        post '/categories', category
        expect(last_request.path).to eq('/categories')
      end
    end

    context 'when trying to add already existing category' do
      before do
        @category = {
          name: 'music',
          description: 'stories about music'
        }
        post '/categories', @category
      end
      it 'should be redirect to addcategories page' do
        post '/categories', @category
        follow_redirect!
        expect(last_request.path).to eq('/addcategories')
        expect(last_response.body).to include('this category already exists!')
      end
    end
  end
end
