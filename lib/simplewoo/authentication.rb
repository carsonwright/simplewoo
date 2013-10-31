# lib/simplewoo/authentication.rb
module Simplewoo
  module Authentication
    def basic_authenticated?
      !!(self.email && self.password)
    end

    def token_authenticated?
      !!(self.api_token)
    end

    def authenticated?
      !!(basic_authenticated? || token_authenticated?)
    end

    # Authenticates the user with their email and password returning an api token
    #
    # @option args [String] email - the email of the user
    # @option args [String] password - the password of the user
    def authenticate(args)
      self.email = args.delete(:email)
      self.password = args.delete(:password)

      unless token_authenticated?
        self.api_token = me.access_token
      end
    end
  end
end
