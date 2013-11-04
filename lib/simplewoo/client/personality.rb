
module Simplewoo
  class Client
    module Personality
      # Returns the personalities for the slider
      #
      # @param [Integer] id - The slider id that the matches are for
      #
      # @return [Hashie::Mash] personalities - the personalities for the slider
      #
      # @example Return the personalities for a slider
      #   Simplewoo::Client.personality_for_slider(1)
      def personality_for_slider(id, options = {})
        get("/sliders/#{id}/results", options)._embedded.personalities
      end

      # Resets the slider
      #
      # @param [Integer] id - The slider id that is reset
      #
      # @return status only
      #
      # @example Return the personalities for a slider
      #   Simplewoo::Client.personality_for_slider(1)
      def reset(id, options = {})
        delete("/sliders/#{id}/reset", options)
      end
    end
  end
end

