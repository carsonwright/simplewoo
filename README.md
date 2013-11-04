# Simplewoo

This is a API wrapper in Ruby for the Woofound Core API. [Woofound](https://woofound.com) is a personality matching and personalization engine. If you are interested in trying the API (currently in early beta stages) email support@woofound.com.

## Installation

Add this line to your application's Gemfile:

    gem 'simplewoo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplewoo

## Usage

### Configuration

	Simplewoo.configure do |client|
	    client.app_secret = "app_secret"
	    client.api_server_host = "api.woofound.com"
	    client.ssl = true
	end

### Users

#### Creating a User

    client.create_user("email@example.com", 
                       "password", 
                       "password", 
                       "first_name", 
                       "last_name", { 
                            :bio => "Some awesome bio.", 
                            :birthday => "1988-01-01"
                        })

#### Updating a User
    client.update_user({
    					:email => "new_email@example.com", 
    					:password => "new_password", 
    					:password_confirmation => "new_password", 
    					"first_name", "last_name", {
    						:bio => "Some awesome bio.", 
    						:birthday => "1988-01-01"
    					})

#### Authenticating a User 
    client.email = "email@example.com"
    client.password = "password"
    client.authenticate

### Getting Sliders

client.sliders


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
