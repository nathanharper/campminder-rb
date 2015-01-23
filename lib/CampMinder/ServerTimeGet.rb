class CampMinder::ServerTimeGet
  include Virtus.model
  include ActiveModel::Serializers::Xml

  attribute :status, String, default: 'True'
  attribute :details, String, default: 'ServerTimeGet'
  attribute :data, String

  def initialize
    super
    @data = Time.now.utc.iso8601.to_s
  end
end
