require 'spec_helper'

describe CampMinder::SignedRequestFactory do
  describe '#initialize' do
    it 'initializes with secret attribute' do
      @signed_request_factory = CampMinder::SignedRequestFactory.new(CampMinder::SECRET_CODE)

      expect(@signed_request_factory).to be_an_instance_of CampMinder::SignedRequestFactory
      expect(@signed_request_factory.send(:secret_code)).to eq CampMinder::SECRET_CODE
    end

    it 'protects the secret_code' do
      @signed_request_factory = CampMinder::SignedRequestFactory.new(CampMinder::SECRET_CODE)

      expect do
        expect(@signed_request_factory.public_send(:secret_code)).to eq CampMinder::SECRET_CODE
      end.to raise_error NoMethodError
    end

    it 'initializes with secret attribute' do
      expect do
        CampMinder::SignedRequestFactory.new
      end.to raise_error ArgumentError
    end
  end

  describe '#get_payload' do
  end
end
