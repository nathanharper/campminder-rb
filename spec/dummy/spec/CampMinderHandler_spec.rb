require 'spec_helper'

describe 'CampMinderHandler' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  describe 'ClientLinkRequest' do
    it 'redirects on success' do
      time = (Time.now.utc + 10).iso8601.to_s
      base64_time = Base64.encode64(time)
      signed_object = CampMinder::SignedRequestFactory.encode_signature(CampMinder::SECRET_CODE, base64_time) + '.' + base64_time
      post '/camp_minder_handler', fn: 'ClientLinkRequest', username: 'johndoe', password: 'secret', signedObject: signed_object, token: 'DEF-456', clientID: 'C-123', personID: 'P-123'

      expect(last_response.status).to eq 304
      expect(last_response.location).to eq "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=true&reason="
    end

    it 'redirects on failure'
  end
end
