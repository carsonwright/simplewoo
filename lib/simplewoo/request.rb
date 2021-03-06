# lib/simplewoo/request.rb
module Simplewoo
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    def put(path, options={})
      request(:put, path, options)
    end

    def delete(path, options={})
      request(:delete, path, options)
    end

    def last_response
      @last_response
    end

    private
    def build_endpoint
      endpoint = ssl ? "https://" : "http://"
      endpoint << self.api_server_host
      self.api_endpoint = endpoint
    end

    def request(method, path, options = {})
      url     = options.delete(:endpoint) || build_endpoint

      connection_options = {}.merge!(:url => url)

      response = connection(connection_options).send(method) do |request|
        case method
        when :get
          request.url(path, options)
        when :post
          request.url(path, options)
        when :put
          request.url(path, options)
        when :delete
          request.url(path, options)
        end
      end

      @last_response = response
      response.body
    end
  end
end

