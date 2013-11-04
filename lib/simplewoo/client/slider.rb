module Simplewoo
  class Client
    module Slider
      # Return the sliders for the app you are on
      #
      # @note requires an authenticated Client instance (app_secret) _not_ an authenticated user
      #
      # @return [Hashie::Mash] sliders - the sliders available for the app
      #
      # @example  Return the sliders for an app
      #   Simplewoo::Client.sliders
      def sliders(options = {})
        get("/sliders", options)
      end

      # Return the requested slider and its associated tags
      #
      # @note requires an authenticated Client instance (app_secret) _not_ an authenticated user
      #
      # @param [Integer] id - the id of the slider that you want to have returned
      #
      # @return [Hashie::Mash] slider - the slider that was requested 
      #
      # @example Return a slider
      #   Simplewoo::Client.slider(1)
      def slider(id, options = {})
        get("/sliders/#{id}", options)
      end
    end
  end
end

