module Simplewoo
  class Client
    module User
      # Create a user on the core api 
      #
      # @param [String] email - the email of the user
      # @param [String] password - the password of the user
      # @param [String] password_confirmation - the password_confirmation of the user
      # @param [String] birthday - the birthday of the user
      # @param [String] first_name - the first name of the user
      # @param [String] last_name - the first name of the user
      #
      # @option options [String] bio - The users bio
      # @option options [String] image - The users image
      #
      # @return [Hashie::Mash] user the user created by the request
      #
      # @example Create a user 
      #   Simplewoo.create_user({
      #     :email => "some@example.com",
      #     :password => "password",
      #     :password_confirmation => "password",
      #     :birthday => "1988-01-01"
      #   })
      def create_user(email, password, password_confirmation, birthday, first_name, last_name, options = {})
        options.merge!({
          :email                 => email,
          :password              => password,
          :password_confirmation => password_confirmation,
          :birthday              => birthday,
          :first_name            => first_name,
          :last_name             => last_name,
        })

        result = post("/users", { :user => options })
        # TODO we should really make this core method return an api_token as well and use that instead
        authenticate({:email => email, :password => password })
        result
      end

      # Returns the currently authenticated user
      # 
      # @note This method requires an authenticated user via email + password or api_token
      # 
      # @example Return the user
      #  Simplewoo.me
      def me 
        if authenticated?
          get("/users/me")
        else
          raise "No authorized user."
        end
      end
    end
  end
end

