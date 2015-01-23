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
      signed_object = encode_signature(CampMinder::SECRET_CODE, base64_time) + '.' + base64_time
      post '/camp_minder_handler', fn: 'ClientLinkRequest', username: 'johndoe', password: 'secret', signedObject: signed_object, token: 'DEF-456', clientID: 'C-123', personID: 'P-123'

      expect(last_response.status).to eq 304
      expect(last_response.location).to eq "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=true&reason="
    end

    it 'redirects on failure' do
      time = (Time.now.utc - 10).iso8601.to_s
      base64_time = Base64.encode64(time)
      signed_object = encode_signature(CampMinder::SECRET_CODE, base64_time) + '.' + base64_time
      post '/camp_minder_handler', fn: 'ClientLinkRequest', username: 'johndoe', password: 'secret', signedObject: signed_object, token: 'DEF-456', clientID: 'C-123', personID: 'P-123'

      expect(last_response.status).to eq 304
      expect(last_response.location).to eq "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=false&reason=Invalid GetLinkRequest - signature was invalid!"
    end
  end

  describe 'ServerTimeGet' do
    it 'responds with server time' do
      post '/camp_minder_handler', fn: 'ServerTimeGet'

      Timecop.freeze(Time.now)

      expect(last_response.status).to eq 200
      expect(last_response.body).to eq %{<?xml version="1.0" encoding="UTF-8"?>
<responseObject>
  <status>True</status>
  <details>ServerTimeGet</details>
  <data>#{Time.now.utc.iso8601.to_s}</data>
</responseObject>
}
    end
  end
end
