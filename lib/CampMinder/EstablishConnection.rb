class CampMinder::EstablishConnection
  include Virtus.model
  include ActiveModel::Serializers::Xml

  attribute :clientID, String
  attribute :personID, String
  attribute :token, String
  attribute :partnerClientID, String

  def initialize(data)
    @clientID = data.fetch('clientID')
    @personID = data.fetch('personID')
    @token = data.fetch('token')
    @partnerClientID = data.fetch('partnerClientID')
  end

  def payload
    to_xml(root: 'responseObject')
  end

  def signed_object
    signed_request_factory = CampMinder::SignedRequestFactory.new(CampMinder::SECRET_CODE)
    signed_request_factory.sign_payload(payload)
  end
end
