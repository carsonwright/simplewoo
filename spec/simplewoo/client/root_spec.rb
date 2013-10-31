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

  let(:email) { "user@example.com" }
  let(:password) { "password" }
  let(:api_token) { "token" }

  context "with basic authentication" do
    let(:client) { Simplewoo::Client.new(:email => email, :password => password) }

    describe ".root" do
      it "returns the HAL links to the api" do
        stub_woo(:get, "/", 200, "#{email}:#{password}@", "root")

        expect(client.root).to respond_to(:_links)
      end
    end
  end

  context "with token authentication" do
    let(:client) { Simplewoo::Client.new(:api_token => api_token) }

    describe ".root" do
      it "returns the HAL links to the api" do
        stub_woo(:get, "/", 200, ":#{api_token}@", "root")

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
end
