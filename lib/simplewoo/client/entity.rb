module Simplewoo
  class Client
    module Entity
      # Returns the matched entities for the slider
      #
      # @param [Integer] slider_id - The slider id that the entities are for
      # @param [Integer] page_id   - The page id that the entities are for
      #
      # @return [Hashie::Mash] Entities - list of entities by page
      #
      # @author Tom Prats
      # Simplewoo::Client.entities(1)
      def entities(slider_id, page_id=1, options = {})
        get("/sliders/#{slider_id}/entities/page/#{page_id}", options)
      end

      # Returns matched the entity
      #
      # @param [Integer] slider_id - The slider id that the entity is for
      # @param [Integer] entity_id - The entity id that the entity is for
      #
      # @return [Hashie::Mash] Entity - the entity requested
      #
      # @author Tom Prats
      # Simplewoo::Client.entity(1, 1)
      def entity(slider_id, entity_id, options = {})
        get("/sliders/#{slider_id}/entities/#{entity_id}", options)
      end
    end
  end
end

