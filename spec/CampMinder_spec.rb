require 'spec_helper'

describe CampMinder do
  it 'has a version number' do
    expect(CampMinder::VERSION).not_to be nil
  end

  it 'has a Business Partner ID' do
    expect(CampMinder::BUSINESS_PARTNER_ID).not_to be nil
  end

  it 'has a Secret Code' do
    expect(CampMinder::SECRET_CODE).not_to be nil
  end

  it 'has a Web Service URL' do
    expect(CampMinder::WEB_SERVICE_URL).not_to be nil
  end

  it 'has a Redirection URL' do
    expect(CampMinder::REDIRECTION_URL).not_to be nil
  end
end
