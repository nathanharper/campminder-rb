require 'spec_helper'

describe CampMinder::ClientLinkRequest do
  before do
    data = {
      'fn' => 'ClientLinkRequest',
      'username' => 'johndoe',
      'password' => 'secret',
      'signedObject' => 'ABC.123',
      'token' => 'DEF-456',
      'clientID' => 'C-123',
      'personID' => 'P-123'
    }
    @client_link_request = CampMinder::ClientLinkRequest.new(data)
  end

  describe '#initialize' do
    it 'initializes with data attribute' do
      expect(@client_link_request).not_to be nil
    end

    it 'assigns the username attribute' do
      expect(@client_link_request.username).to eq 'johndoe'
    end

    it 'assigns the password attribute'
    it 'assigns the signed_object attribute'
    it 'assigns the token attribute'
    it 'assigns the client_id attribute'
    it 'assigns the person_id attribute'
  end

  describe '#valid?' do
    it 'returns false' do
      expect(@client_link_request.valid?).to be false
    end
  end

  describe '#expiration_time' do

  end
end
