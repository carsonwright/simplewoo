# spec/simplewoo/client/user.rb
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

  describe ".create_user" do
    let(:client) { Simplewoo::Client.new }

    context "valid" do
      let(:response) {
        client.create_user("jason@example.com", "password", "password", "Jason", "Truluck", { :bio => "Some awesome bio.", :birthday => "1988-01-01"})
      }

      before(:each) do
        stub_woo(:post, "/users?user%5Bbirthday%5D=Jason&user%5Bemail%5D=jason@example.com&user%5Bfirst_name%5D=Truluck&user%5Blast_name%5D%5Bbio%5D=Some%20awesome%20bio.&user%5Blast_name%5D%5Bbirthday%5D=1988-01-01&user%5Bpassword%5D=password&user%5Bpassword_confirmation%5D=password", "user")
        stub_woo(:get, "/users/me", 200, "jason@example.com:password@", "me")

        # Initializes the user for the client
        response
      end

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
        expect(client.me).to respond_to(:email)
      end
    end

    context "authenticated with trusted authentication" do
      let(:client) { Simplewoo::Client.new(:trusted => true, :email => "jason@example.com") }

      before(:each) do
        stub_woo(:get, "/users/me", "me")
      end

      it "returns the authenticated user" do
        expect(client.me).to respond_to(:email)
      end
    end

    context "unauthenticated" do
      let(:client) { Simplewoo::Client.new }

      it "raises a Simplewoo::Unauthorized error" do
        expect{ client.me }.to raise_error("No authorized user.")
      end
    end
  end

  describe ".update_user" do
    let(:response) { client.update_user({:email => "tom@example.com"}) }

    context "authenticated" do
      let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

      it "updates user email field" do
        stub_woo(:put, "/users/me?user%5Bemail%5D=tom@example.com", 200, ":some_token@", "updated_user")

        expect(response.email).to eq("tom@example.com")
      end
    end

    context "unauthenticated" do
      let(:client) { Simplewoo::Client.new }

      it "raises a Simplewoo::Unauthorized error" do
        stub_woo(:put, "/users/me?user%5Bemail%5D=tom@example.com", "updated_user")

        expect{ response }.to raise_error("No authorized user.")
      end
    end
  end

  describe ".reset_password" do
    let(:response) { client.update_user({:password => "awesome_password", :password_confirmation => "awesome_password" }) }

    context "authenticated" do
      let(:client) { Simplewoo::Client.new(:api_token => "some_token") }

      # PENDING Update the core to revalidate the access token on successful password change
      it "updates user password"
    end

    context "unauthenticated" do
      let(:client) { Simplewoo::Client.new }

      it "raises a Simplewoo::Unauthorized error" do
        stub_woo(:put, "/users/me?user%5Bpassword%5D=awesome_password%5Bpassword_confirmation%5D=awesome_password", "updated_user")

        expect{ response }.to raise_error("No authorized user.")
      end
    end
  end
end
