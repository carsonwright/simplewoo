# spec/simplewoo/client/tag_spec.rb
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

  describe ".add_tag" do
    let(:client) { Simplewoo::Client.new(api_token: "some_token") }
    let(:response) { client.add_tag(1, 1, true) }

    it "adds a tag for a user" do
      stub_woo(:post, "/sliders/1/tags/1?me=true", 204, ":some_token@", "empty")
      response
      expect(client.last_response.status).to eq(204)
    end
  end

  describe ".show_tag" do
    let(:client) { Simplewoo::Client.new(api_token: "some_token") }
    let(:response) { client.tag(1) }

    it "adds a tag for a user" do
      stub_woo(:get, "/tags/1", 200, ":some_token@", "tag")
      expect(response.name).to eq("Going Camping")
    end
  end
end

