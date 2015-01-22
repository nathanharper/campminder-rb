require 'base64'

class CampMinder::SignedRequestFactory
  include Virtus.model

  attribute :secret_code, String, writer: :private, reader: :private

  def initialize(secret_code)
    @secret_code = secret_code
  end

  def get_payload(signed_payload)
    Base64.decode64(signed_payload.split('.').last)
  end
end
