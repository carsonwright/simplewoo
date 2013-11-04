# spec/simplewoo/client/personality_spec.rb
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

  describe ".personality_for_slider" do
    let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

    it "personality for the slider for the current user" do
      expect(client.personality_for_slider(1)).to be_a(Array)
    end

    it "returns the personality of the authenticated user" do
      expect(client.personality_for_slider(1)).to_not be_empty
    end
  end

  describe ".reset" do
    let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

    it "resets the personality" do
      stub_woo(:delete, "/sliders/1/reset", 200, ":some_token@", "match_results")
      client.reset(1)

      expect(WebMock).to have_requested(:delete, "https://:some_token@api.woofound.com/sliders/1/reset").once
    end
  end
end
