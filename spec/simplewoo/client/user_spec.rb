# spec/simplewoo/client/user.rb
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

  describe ".create_user" do
    let(:client) { Simplewoo::Client.new }

    context "valid" do
      before(:each) do
        stub_woo(:post, "/users?user%5Bbirthday%5D=Jason&user%5Bemail%5D=jason@example.com&user%5Bfirst_name%5D=Truluck&user%5Blast_name%5D%5Bbio%5D=Some%20awesome%20bio.&user%5Blast_name%5D%5Bbirthday%5D=1988-01-01&user%5Bpassword%5D=password&user%5Bpassword_confirmation%5D=password", "user")
        stub_woo(:get, "/users/me", 200, "jason@example.com:password@", "me")
      end

      let(:response) {
        client.create_user("jason@example.com", "password", "password", "Jason", "Truluck", { :bio => "Some awesome bio.", :birthday => "1988-01-01"})
      }

      it "returns the users email" do
        expect(response).to respond_to(:email)
      end

      it "queries the Core API" do
        expect(WebMock).to have_requested(:get, "https://jason@example.com:password@api.woofound.com/users/me").once
      end

      it "sets the api_token" do
        expect(client.api_token).to eq("acce$$token") 
      end
    end
  end

  describe ".me" do
    context "authenticated" do
      let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

      before(:each) do
        stub_woo(:get, "/users/me", 200, ":some_token@", "me")
      end

      it "returns the authenticated user" do
        expect(client.me).to_not be_nil
      end

      it "queries the Core API" do
        client.me
        expect(WebMock).to have_requested(:get, "https://:some_token@api.woofound.com/users/me").once
      end
    end

    context "unauthenticated" do
      let(:client) { Simplewoo::Client.new }

      it "raises a Simplewoo::Unauthorized error" do
        expect{ client.me }.to raise_error("No authorized user.")
      end
    end
  end
end
