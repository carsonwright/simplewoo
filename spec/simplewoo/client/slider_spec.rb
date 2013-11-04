# spec/simplewoo/client/slider_spec.rb
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

  describe ".sliders" do
    let(:client) { Simplewoo::Client.new }

    before(:each) do
      stub_woo(:get, "/sliders", "sliders")
    end

    it "returns the sliders for the app" do
      expect(client.sliders).to respond_to(:_embedded)
    end
  end

  describe ".slider" do
    let(:client) { Simplewoo::Client.new }

    before(:each) do
      stub_woo(:get, "/sliders/1", "slider")
    end

    it "returns the sliders for the app" do
      expect(client.slider(1)).to respond_to(:_embedded)
    end
  end
end
