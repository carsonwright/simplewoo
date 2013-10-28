# lib/simplewoo/authentication.rb

module Simplewoo
  module Authentication
    def authenticate(options = {})
      self.api_token = options.delete(:api_token)
      if self.api_token
        connection.basic("", self.api_token)
      else
        connection.basic_auth(self.email, options.delete(:password))
      end
    end
  end
end
