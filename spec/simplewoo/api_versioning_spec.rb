# spec/simplewoo/error.rb
require "spec_helper"

describe Simplewoo::Client do
 before do
    Simplewoo.reset!
    Simplewoo.configure do |client|
      client.app_secret = "app_secret"
      client.api_server_host = "api.woofound.com"
      client.ssl = true
      client.version = :v2
    end
  end

  describe ".version" do
    let(:client) { Simplewoo::Client.new(api_token: "some_token") }

    it "adds a tag for a user" do
      stub_woo(:get, "/users/me", 200, ":some_token@", "me")
      client.authenticate
      client.me
      expect(client.last_response.status).to eq(200)
    end
  end
end
