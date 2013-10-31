require 'rubygems'
require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'
class SimpleCov::Formatter::QualityFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    File.open("coverage/covered_percent", "w") do |f|
      f.puts result.source_files.covered_percent.to_f
    end
  end
end
SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter

require 'simplewoo'
require "webmock/rspec"

Dir[File.expand_path("spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.color_enabled = true
  config.order                                           = "random"
end

def stub_woo(http_method = :any, endpoint = "/", status = 200, auth = nil, response)
  url = "https://#{auth}api.woofound.com#{endpoint}"
  stub_request(http_method, url).
  to_return(:status => status, 
            :body => File.read(File.expand_path("../support/mocks/#{response}.json", __FILE__)),
            :headers =>{'Accept' => "application/json", 'Content-type' => "application/json"})
end
