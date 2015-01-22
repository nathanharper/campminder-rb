class CampMinder::SignedRequestFactory
  include Virtus.model

  attribute :secret_code, String, writer: :private, reader: :private

  def initialize(secret_code)
    @secret_code = secret_code
  end
end
