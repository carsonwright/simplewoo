module Simplewoo
  class Client
    module User
      # .create_user
      #
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
          :password              =>  password,
          :password_confirmation =>  password_confirmation,
          :first_name            =>  first_name,
          :last_name             =>  last_name,
        })

        post("/users", { :user => options })
      end
    end
  end
end

