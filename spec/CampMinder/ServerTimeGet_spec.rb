require 'spec_helper'

describe CampMinder::ServerTimeGet do
  before do
    Timecop.freeze(Time.now)
    @server_time_get = CampMinder::ServerTimeGet.new
  end

  describe '#initialize' do
    it 'initializes' do
      expect(@server_time_get).not_to be nil
    end

    it 'assigns the data attribute' do
      expect(@server_time_get.data).to eq Time.now.utc.iso8601.to_s
    end

    it 'status attribute is True' do
      expect(@server_time_get.status).to eq 'True'
    end

    it 'details attribute is ServerTimeGet' do
      expect(@server_time_get.details).to eq 'ServerTimeGet'
    end
  end
end
