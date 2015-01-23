require 'spec_helper'

describe CampMinder::EstablishConnection do
  before do
    @data = {
      'clientID' => 'C-123',
      'personID' => 'P-123',
      'token' => 'DEF-456',
      'partnerClientID' => 'IEX-C-123'
    }

    @payload = %{<?xml version="1.0" encoding="UTF-8"?>
<responseObject>
  <clientID>#{@data['clientID']}</clientID>
  <personID>#{@data['personID']}</personID>
  <token>#{@data['token']}</token>
  <partnerClientID>#{@data['partnerClientID']}</partnerClientID>
</responseObject>
}

    @encoded_payload = Base64.encode64(@payload)
    @encoded_signature = encode_signature(CampMinder::SECRET_CODE, @encoded_payload)
    @signed_payload = "#{@encoded_signature}.#{@encoded_payload}"

    @establish_connection = CampMinder::EstablishConnection.new(@data)
  end

  describe '#initialize' do
    it 'initializes with data attribute' do
      expect(@establish_connection).not_to be nil
    end

    it 'assigns the clientID attribute' do
      expect(@establish_connection.clientID).to eq @data['clientID']
    end

    it 'assigns the personID attribute' do
      expect(@establish_connection.personID).to eq @data['personID']
    end

    it 'assigns the token attribute' do
      expect(@establish_connection.token).to eq @data['token']
    end

    it 'assigns the partnerClientID attribute' do
      expect(@establish_connection.partnerClientID).to eq @data['partnerClientID']
    end

    it 'raises an exception on missing attributes' do
      data_without_clientid = @data.tap { |data| data.delete('clientID') }

      expect do
        CampMinder::EstablishConnection.new(data_without_clientid)
      end.to raise_error KeyError
    end
  end

  describe '#payload' do
    it 'generates an xml payload' do
      expect(@establish_connection.payload).to eq @payload
    end
  end

  describe '#signed_object' do
    it 'signs the connection request' do
      expect(@establish_connection.signed_object).to eq @signed_payload
    end
  end

  describe '#connect' do
    before do
      @form_params = {
        'businessPartnerID' => CampMinder::BUSINESS_PARTNER_ID,
        'signedObject' => @signed_payload
      }
    end

    it 'sends a failed connection post request to CampMinder' do
      stub_request(:post, CampMinder::WEB_SERVICE_URL).
      with(body: @form_params).
      to_return(body: %{<?xml version="1.0" encoding="UTF-8"?>
<responseObject version="1">
  <Success>False</Success>
  <Reason>Unknown</Reason>
</responseObject>
})
      expect(@establish_connection.connect).to be false
      expect(@establish_connection.connection_failure_reason).to eq 'Unknown'
    end

    it 'sends a successful connection post request to CampMinder' do
      stub_request(:post, CampMinder::WEB_SERVICE_URL).
      with(body: @form_params).
      to_return(body: %{<?xml version="1.0" encoding="UTF-8"?>
<responseObject version="1">
  <Success>True</Success>
</responseObject>
})
      expect(@establish_connection.connect).to be true
      expect(@establish_connection.connection_failure_reason).to be nil
    end
  end
end
