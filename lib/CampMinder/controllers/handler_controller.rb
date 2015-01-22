module CampMinder::HandlerController
  def create
    @client_link_request = CampMinder::ClientLinkRequest.new(params)

    success = @client_link_request.valid_expiration_time?
    reason = @client_link_request.invalid_reason

    redirect_to "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=#{success}&reason=#{reason}", status: 304
  end
end
