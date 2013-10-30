# spec/simplewoo/error.rb
require "spec_helper"

describe Simplewoo::Error do
  before do
    Simplewoo.reset!
    Simplewoo.configure do |client|
      client.app_secret = "app_secret"
      client.api_server_host = "api.woofound.com"
      client.ssl = true
    end
  end

  let(:client) { Simplewoo::Client.new(:email => "user@example.com", :password => "somepassword") }

  describe ".errors" do
     it "returns a hash of methods" do
      stub_woo(:get, "/", 401, "bad_app_secret")

      begin
        client.root
      rescue Simplewoo::Unauthorized => e
        expect(e.errors).to eq({"errors"=>["Missing app secret"]})
      end
    end
  end

  describe "#from" do
    describe "400 Error" do
      it "raises a Simplewoo::BadRequest error" do
        stub_woo(:get, "/", 400, "root")

        expect{ client.root }.to raise_error(Simplewoo::BadRequest)
      end
    end

    describe "401 Error" do
      it "raises a Simplewoo::Unauthorized error" do
        stub_woo(:get, "/", 401, "root")

        expect{ client.root }.to raise_error(Simplewoo::Unauthorized)
      end
    end

    describe "404 Error" do
      it "raises a Simplewoo::NotFound error" do
        stub_woo(:get, "/", 404, "root")

        expect{ client.root }.to raise_error(Simplewoo::NotFound)
      end
    end

    describe "422 Error" do
      it "raises a Simplewoo::UnprocessibleEntity error" do
        stub_woo(:get, "/", 422, "root")

        expect{ client.root }.to raise_error(Simplewoo::UnprocessableEntity)
      end
    end
  end
end
