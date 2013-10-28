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

  context "valid" do
    let(:client) { Simplewoo::Client.new(:email => "user@example.com", :password => "somepassword") }

    describe ".create_user" do
      before(:each) do
        stub_woo(:post, "/users?user%5Bemail%5D=jason@example.com&user%5Bfirst_name%5D=Truluck&user%5Blast_name%5D%5Bbio%5D=Some%20awesome%20bio.&user%5Blast_name%5D%5Bbirthday%5D=1988-01-01&user%5Bpassword%5D=password&user%5Bpassword_confirmation%5D=password", "user")
      end

      let(:response) {
        client.create_user("jason@example.com", "password", "password", "Jason", "Truluck", { :bio      => "Some awesome bio.",:birthday => "1988-01-01"})
      }

      it "returns the users email" do
        expect(response).to respond_to(:email)
      end
    end
  end
end
