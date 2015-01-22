require 'spec_helper'

describe 'CampMinderHandler' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  it 'returns hello' do
    get '/'
    expect(last_response.body).not_to be nil
  end
end
