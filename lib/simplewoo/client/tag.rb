module Simplewoo
  class Client
    module Tag
      # Returns the matched entities and matched personalities for the slider
      #
      # @param [Integer] slider_id - The slider id that the matches are for
      # @param [Integer] tag_id - The tag id that the matches are for
      # @param [Boolean] value - The tag id that the matches are for
      #
      # @author Carson Wright
      # @author Chris Preisinger
      # Simplewoo::Client.add_tag(1, 1, true)
      def add_tag(slider_id, tag_id, value, options = {})
        options.merge!(me: value)
        post("/sliders/#{slider_id}/tags/#{tag_id}/add", options)
      end

      # Returns a tag
      #
      # @param [Integer] tag_id - The tag id you want returned 
      #
      # @return [Hashie::Mash] Tag - the requested tag
      #
      # @author Carson Wright
      # Simplewoo::Client.tag(1, 1, true)
      def tag(tag_id, options = {})
        get("/tags/#{tag_id}", options)
      end
    end
  end
end

