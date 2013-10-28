# spec/simplewoo/client/root.rb
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

  context "with authentication" do
    let(:client) { Simplewoo::Client.new(:email => "user@example.com", :password => "somepassword") }

    describe ".root" do
      it "returns the HAL links to the api" do
        stub_woo(:get, "/", "root")

        expect(client.root).to respond_to(:_links)
      end
    end
  end

  context "without authentication" do
    let(:client) { Simplewoo::Client.new }

    describe "#root" do
      it "returns the HAL links to the api" do
        stub_woo(:get, "/", "root")

        expect(client.root).to respond_to(:_links)
      end
    end
  end

  context "with invalid Woofound-App-Secret" do
    it "raises a AppSecretInvalid error"
  end
end
