# spec/simplewoo/client/match_spec.rb
require "spec_helper"

describe Simplewoo::Client do
  before do
    Simplewoo.reset!
    Simplewoo.configure do |client|
      client.app_secret = "app_secret"
      client.api_server_host = "api.woofound.com"
      client.ssl = true
    end
  end

  before(:each) do
    stub_woo(:get, "/sliders/1/results", 200, ":some_token@", "match_results")
  end

  describe ".match_for_slider" do
    let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

    it "returns the entities matched to the authenticated user" do
      expect(client.match_for_slider(1)).to respond_to(:entities)
    end

    it "returns the personality of the authenticated user" do 
      expect(client.match_for_slider(1)).to respond_to(:personalities)
    end
  end
end
