class CampMinder::ClientLinkRequest
  include Virtus.model

  attribute :username, String
  attribute :password, String
  attribute :signed_object, String
  attribute :token, String
  attribute :client_id, String
  attribute :person_id, String

  def initialize(args)
    @username = args.fetch('username')
    @password = args.fetch('password')
    @signed_object = args.fetch('signedObject')
    @token = args.fetch('token')
    @client_id = args.fetch('clientID')
    @person_id = args.fetch('personID')
  end

  def expiration_time
    DateTime.parse(signed_request_factory.get_payload(@signed_object))
  end

  def valid?
    false
  end

  private

  def signed_request_factory
    @signed_request_factory ||= CampMinder::SignedRequestFactory.new
  end
end
