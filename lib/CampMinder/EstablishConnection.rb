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

  def connect
    uri = URI(CampMinder::WEB_SERVICE_URL)
    res = Net::HTTP.post_form(uri, 'businessPartnerID' => CampMinder::BUSINESS_PARTNER_ID, 'signedObject' => signed_object)
    doc = Nokogiri.XML(res.body)
    success = doc.at_xpath('//Success').content

    case success
    when 'True'
      true
    when 'False'
      @failure_reason = doc.at_xpath('//Reason').content
      false
    end
  end

  def connection_failure_reason
    @failure_reason
  end
end
