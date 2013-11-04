# lib/simplewoo/client.rb
# require base modules
require "simplewoo/authentication"
require "simplewoo/connection"
require "simplewoo/request"
# require client modules in lib/simplewoo/client
Dir[File.expand_path("../client/*.rb", __FILE__)].each {|f| require f }

module Simplewoo
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Simplewoo.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Simplewoo::Authentication
    include Simplewoo::Connection
    include Simplewoo::Request

    include Simplewoo::Client::Root
    include Simplewoo::Client::User
    include Simplewoo::Client::Slider
    include Simplewoo::Client::Match
    include Simplewoo::Client::Personality
    include Simplewoo::Client::Tag
    include Simplewoo::Client::Entity
  end
end
