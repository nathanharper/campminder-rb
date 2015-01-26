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

    partner_client_id = nil

    if success
      partner_client_id = verify_username_password(@client_link_request.username, @client_link_request.password)

      if !partner_client_id
        success = false
        reason = 'invalid username and password'
      end
    end

    if success
      connection = CampMinder::EstablishConnection.new(
        'clientID' => @client_link_request.client_id,
        'personID' => @client_link_request.person_id,
        'token' => @client_link_request.token,
        'partnerClientID' => partner_client_id
      )

      if !connection.connect
        success = false
        reason = connection.connection_failure_reason
      end
    end

    if success
      success = store_partner_client(
        partner_client_id,
        @client_link_request.client_id,
        @client_link_request.person_id,
        @client_link_request.token,
        1 # TODO: what is connection status for? If we've reached this point, they are presumably connected.
      )
      reason = 'failed to save partner client' unless success
    end

    redirect_to "#{CampMinder::REDIRECTION_URL}?bpid=#{CampMinder::BUSINESS_PARTNER_ID}&success=#{success}&reason=#{reason}", status: 304
  end

  def server_time_get
    render xml: CampMinder::ServerTimeGet.new, root: 'responseObject'
  end

  def verify_username_password(username, password)
    raise NotImplementedError
  end

  def store_partner_client(partner_client_id, client_id, person_id, token, connection_status)
    raise NotImplementedError
  end
end
