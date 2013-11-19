# spec/simplewoo/client/entity_spec.rb
require "spec_helper"

describe Simplewoo::Client do
  before do
    Simplewoo.reset!
    Simplewoo.configure do |client|
      client.app_secret = "app_secret"
      client.api_server_host = "api.woofound.com"
      client.ssl = true
      client.version = :v1
    end
  end

  describe ".entities" do
    let(:client) { Simplewoo::Client.new(api_token: "some_token") }
    let(:response) { client.entities(1, 1) }

    it "gets the entities for a slider" do
      stub_woo(:get, "/sliders/1/entities/page/1", 200, ":some_token@", "entities")
      expect(response["_embedded"]["entities"][0].name).to eq("Nursery Worker")
    end
  end

  describe ".entity" do
    let(:client) { Simplewoo::Client.new(api_token: "some_token") }
    let(:response) { client.entity(2, 12914) }

    it "gets an entity for a slider" do
      stub_woo(:get, "/sliders/2/entities/12914", 200, ":some_token@", "entity")
      expect(response.name).to eq("Bartender")
    end
  end
end

