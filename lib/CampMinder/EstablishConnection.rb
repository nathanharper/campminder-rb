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
    uri = URI.parse(CampMinder::WEB_SERVICE_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({'fn' => 'EstablishConnection', 'businessPartnerID' => CampMinder::BUSINESS_PARTNER_ID, 'signedObject' => signed_object})
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(request)

    doc = Nokogiri.XML(response.body)
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
