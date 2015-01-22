require 'spec_helper'

describe CampMinder::ClientLinkRequest do
  describe '#initialize' do
    it 'initializes with attributes' do
      client_link_request = CampMinder::ClientLinkRequest.new
      expect(client_link_request).not_to be nil
    end
  end

  describe '#valid?' do
    it 'returns false' do
      client_link_request = CampMinder::ClientLinkRequest.new
      expect(client_link_request.valid?).to be false
    end
  end
end
