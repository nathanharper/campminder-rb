require 'spec_helper'

describe CampMinder::ClientLinkRequest do
  before do
    @signed_request_factory = double("SignedRequestFactory", get_payload: nil)
    allow(CampMinder::SignedRequestFactory).to receive(:new).and_return(@signed_request_factory)

    @data = {
      'fn' => 'ClientLinkRequest',
      'username' => 'johndoe',
      'password' => 'secret',
      'signedObject' => 'ABC.123',
      'token' => 'DEF-456',
      'clientID' => 'C-123',
      'personID' => 'P-123'
    }
    @client_link_request = CampMinder::ClientLinkRequest.new(@data)
  end

  describe '#initialize' do
    it 'initializes with data attribute' do
      expect(@client_link_request).not_to be nil
    end

    it 'assigns the username attribute' do
      expect(@client_link_request.username).to eq 'johndoe'
    end

    it 'assigns the password attribute' do
      expect(@client_link_request.password).to eq 'secret'
    end

    it 'assigns the signed_object attribute' do
      expect(@client_link_request.signed_object).to eq 'ABC.123'
    end

    it 'assigns the token attribute' do
      expect(@client_link_request.token).to eq 'DEF-456'
    end

    it 'assigns the client_id attribute' do
      expect(@client_link_request.client_id).to eq 'C-123'
    end

    it 'assigns the person_id attribute' do
      expect(@client_link_request.person_id).to eq 'P-123'
    end

    it 'raises an exception on missing attributes' do
      data_without_username = @data.tap { |data| data.delete('username') }

      expect do
        CampMinder::ClientLinkRequest.new(data_without_username)
      end.to raise_error KeyError
    end
  end

  describe '#expiration_time' do
    it 'unencodes the expiration time' do
      expect(@signed_request_factory).to receive(:get_payload).with(@client_link_request.signed_object).and_return('2011-04-13T17:15:49Z')
      expect(@client_link_request.expiration_time).to eq Time.new(2011, 4, 13, 17, 15, 49, 0)
    end
  end

  describe '#valid_expiration_time?' do
    it 'returns true if date has not passed' do
      allow(@client_link_request).to receive(:expiration_time).and_return(Time.now + 1)
      expect(@client_link_request.valid_expiration_time?).to be true
    end

    it 'returns false if date is now' do
      allow(@client_link_request).to receive(:expiration_time).and_return(Time.now)
      expect(@client_link_request.valid_expiration_time?).to be false
    end

    it 'returns false if date has passed' do
      allow(@client_link_request).to receive(:expiration_time).and_return(Time.now - 1)
      expect(@client_link_request.valid_expiration_time?).to be false
    end
  end

  describe '#invalid_reason' do
    it 'returns nil if valid_expiration_time?' do
      allow(@client_link_request).to receive(:valid_expiration_time?).and_return(true)
      expect(@client_link_request.invalid_reason).to eq nil
    end

    it 'returns message if not valid_expiration_time?' do
      allow(@client_link_request).to receive(:valid_expiration_time?).and_return(false)
      expect(@client_link_request.invalid_reason).to eq "Invalid GetLinkRequest - signature was invalid!"
    end
  end
end
