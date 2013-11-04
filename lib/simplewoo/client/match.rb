module Simplewoo
  class Client
    module Match
      # Returns the matched entities and matched personalities for the slider
      #
      # @param [Integer] id - The slider id that the matches are for
      #
      # @return [Hashie::Mash] matches - the matches for the slider
      #
      # @example Return the entity matches for a slider
      #   Simplewoo::Client.match_for_slider(1).entities
      # @example Return the personality matches for a slider
      #   Simplewoo::Client.match_for_slider(1).personalities
      def match_for_slider(id, options = {})
        get("/sliders/#{id}/results", options)._embedded
      end
    end
  end
end

