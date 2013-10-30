# lib/simplewoo/error.rb
require "pry"
module Simplewoo
  class Error < StandardError
  	attr_accessor :response

  	def self.from(response)
  		status  = response.status

  		if klass = case status
	  		when 400 then Simplewoo::BadRequest
	  		when 401 then Simplewoo::Unauthorized
	  		when 404 then Simplewoo::NotFound
			when 422 then Simplewoo::UnprocessableEntity
	  		end

	  		klass.new(response)
	  	end
  	end

  	def initialize(response)
  		@response = response
  		super(error_message)
  	end

  	def errors
  		response.body
  	end

  	private
  	def error_message
  		message = "#{response.env[:method].upcase} #{response.env[:url].to_s} | #{response.status}: #{JSON.parse(response.body).map{|k,v| "#{k}: #{v.first}"}.join(", ")}"
  	end
  end

  # Raised when Woofound Core Api returns a 400 HTTP status code
  class BadRequest < Error; end
  # Raised when Woofound Core Api returns a 401 HTTP status code
  class Unauthorized < Error; end
  # Raised when Woofound Core Api returns a 404 HTTP status code
  class NotFound < Error; end
  # Raised when Woofound Core Api returns a 422 HTTP status code
  class UnprocessableEntity < Error; end
end