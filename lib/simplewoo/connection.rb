# lib/simplewoo/connection.rb
require "json"
require "faraday_middleware"
require "simplewoo/error"
require "pry"

module Simplewoo
  module Connection
    def connection(options = {})
      connection ||= Faraday.new(options) do |faraday|
        faraday.request :url_encoded
        if basic_authenticated?
          faraday.request :basic_auth, self.email, self.password
        elsif token_authenticated?
          faraday.request :token_auth, self.api_token
        end
        faraday.use AppSecretMiddleware, app_secret: self.app_secret
        faraday.use TrustedAppMiddleware, trusted: self.trusted
        faraday.use FaradayMiddleware::Mashify
        faraday.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
        faraday.use ErrorMiddleware
        faraday.adapter Faraday.default_adapter
      end

      p connection

      connection
    end

    private
    # Middleware for inserting the app secret header into requests
    class AppSecretMiddleware < Faraday::Middleware
      def initialize(app, options = {})
        @app = app 
        @options = options
      end

      def call(env)
        env[:request_headers]["Woofound-App-Secret"] = @options[:app_secret]
        @app.call(env)
      end
    end
    # Middleware for inserting the trusted header into requests
    class TrustedAppMiddleware < Faraday::Middleware
      def initialize(app, options = {})
        @app = app 
        @options = options
      end

      def call(env)
        env[:request_headers]["Woofound-Use-Trusted"] = @options[:trusted]
        @app.call(env)
      end
    end
    # Middleware for responding to Errors returned from the api
    class ErrorMiddleware < Faraday::Middleware
      def initialize(app)
        @app = app 
      end

      def call(env)
        @app.call(env).on_complete do |env|
          if error = Simplewoo::Error.from(env[:response])
            raise error
          end
        end
      end
    end
  end
end
