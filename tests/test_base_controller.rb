require './helpers/spec_helper.rb'

describe 'Micro Learning Application' do
  context 'When user tries to access landing page' do
    it 'should access successfully' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  context 'When user tries to dashboard' do
    it 'should redirect to login' do
      get '/dashboard'
      expect(last_response).to be_redirect
    end
  end

end