# lib/simplewoo/authentication.rb
module Simplewoo
  module Authentication
    def basic_authenticated?
      !!(self.email && self.password)
    end

    def token_authenticated?
      !!(self.api_token)
    end
  end
end
