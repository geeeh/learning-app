# frozen_string_literal: true

require_relative '../spec_helper.rb'

describe 'Micro Learning Application' do
  context 'When user tries to access landing page' do
    before do
      get '/'
    end
    it 'should access successfully' do
      expect(last_response).to be_ok
    end

    it 'should include landing page content' do
      expect(last_response.body).to include('Do not get left behind.')
    end
  end
end
