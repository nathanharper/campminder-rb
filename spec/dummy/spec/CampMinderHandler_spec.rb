require 'spec_helper'

describe 'CampMinderHandler' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  describe 'ClientLinkRequest' do
    it 'returns hello' do
      post '/camp_minder_handler', fn: 'ClientLinkRequest', username: 'johndoe', password: 'secret', signedObject: 'ABC.123', token: 'DEF-456', clientID: 'C-123', personID: 'P-123'
      expect(last_response.status).to be 200
    end
  end
end
