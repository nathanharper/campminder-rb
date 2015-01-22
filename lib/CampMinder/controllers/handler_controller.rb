module CampMinder::HandlerController
  def create
    @client_link_request = CampMinder::ClientLinkRequest.new(params)

    success = true

    redirect_to "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=#{success}&reason=", status: 304
  end
end
