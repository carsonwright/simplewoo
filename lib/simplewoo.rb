require "simplewoo/version"
require "simplewoo/configuration"
require "simplewoo/client"

module Simplewoo
  extend Configuration

  class << self
    # Alias method for Simplewoo::Client.new
    def new(options = {})
      Simplewoo::Client.new(options)
    end
  end
end
