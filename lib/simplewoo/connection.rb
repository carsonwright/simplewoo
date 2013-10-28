# lib/simplewoo/connection.rb
require "json"
require "faraday_middleware"

module Simplewoo
  module Connection
    def connection(options = {})
      connection ||= Faraday.new(options) do |faraday|
        faraday.request :url_encoded
        faraday.use AppSecretMiddleware
        faraday.use TrustedAppMiddleware
        faraday.use FaradayMiddleware::Mashify
        faraday.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    private
    # Middleware for inserting the app secret header into requests
    class AppSecretMiddleware < Faraday::Middleware
      def call(env)
        env[:request_headers]["Woofound-App-Secret"] = Simplewoo.app_secret
        @app.call(env)
      end
    end
    #
    # Middleware for inserting the trusted header into requests
    class TrustedAppMiddleware < Faraday::Middleware
      def call(env)
        env[:request_headers]["Woofound-Use-Trusted"] = Simplewoo.trusted
        @app.call(env)
      end
    end
  end
end
