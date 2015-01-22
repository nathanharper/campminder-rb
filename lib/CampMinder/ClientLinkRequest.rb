class CampMinder::ClientLinkRequest
  include Virtus.model

  attribute :username, String

  def initialize(args)
    @username = args.fetch('username')
  end

  def valid?
    false
  end
end
