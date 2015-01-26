module CampMinder::HandlerController
  def create
    case params[:fn]
    when 'ClientLinkRequest'
      client_link_request
    when 'ServerTimeGet'
      server_time_get
    end
  end

  private

  def client_link_request
    @client_link_request = CampMinder::ClientLinkRequest.new(params)

    success = @client_link_request.valid_expiration_time?
    reason = @client_link_request.invalid_reason

    if success
      connection = CampMinder::EstablishConnection.new(
        'clientID' => @client_link_request.client_id,
        'personID' => @client_link_request.person_id,
        'token' => @client_link_request.token,
        'partnerClientID' => "TODO"
      )

      if !connection.connect
        success = false
        reason = connection.connection_failure_reason
      end
    end

    redirect_to "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=#{success}&reason=#{reason}", status: 304
  end

  def server_time_get
    render xml: CampMinder::ServerTimeGet.new, root: 'responseObject'
  end
end
