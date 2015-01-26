module CampMinderSpecs
  def encode_signature(secret_code, encoded_payload)
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret_code, encoded_payload)).strip()
  end
end
