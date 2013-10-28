module Simplewoo
  class Client
    module Root
      def root(options = {})
        get("/", options)
      end
    end
  end
end

