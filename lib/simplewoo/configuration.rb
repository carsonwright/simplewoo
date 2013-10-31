# lib/simplewoo/configuration.rb#
module Simplewoo
  module Configuration
    # TODO try to remove redis
    VALID_OPTIONS_KEYS = [
      :app_secret,
      :api_server_host,
      :api_endpoint,
      :trusted,
      :ssl,
      :email,
      :password,
      :api_token,
      :debug
    ]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset!
      VALID_OPTIONS_KEYS.each {|key| class_eval(%Q{key = nil}) }
      self.trusted = "false"
      self.ssl = true
      self.debug = false
    end
  end
end
