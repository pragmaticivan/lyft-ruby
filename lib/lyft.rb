require "oauth2"

require 'lyft/errors'
require 'lyft/raise_error'
require 'lyft/version'
require "lyft/configuration"

require 'lyft/oauth2'

# Coerces Lyft JSON to a nice Ruby hash
# Lyft::Mash inherits from Hashie::Mash
require "hashie"
require "lyft/mash"

# Wraps a Lyft-specifc API connection
# Lyft::Connection inherits from Faraday::Connection
require "faraday"
require "lyft/connection"

# Data object to wrap API access token
require "lyft/access_token"

# Endpoints inherit from APIResource
require "lyft/api_resource"

# All of the endpoints
require "lyft/rides"

# The primary API object that makes requests.
# It composes in all of the endpoints
require "lyft/api"


module Lyft
  @config = Configuration.new

  class << self
    attr_accessor :config
  end

  def self.configure
    yield self.config
  end
end
