module Lyft
  class Configuration
    attr_accessor :api,
                  :site,
                  :scope,
                  :client_id,
                  :token_url,
                  :api_version,
                  :redirect_uri,
                  :authorize_url,
                  :client_secret,
                  :default_profile_fields

    alias_method :api_key, :client_id
    alias_method :secret_key, :client_secret

    def initialize
      @api = "https://api.lyft.com"
      @api_version = "/v1"
      @site = "https://api.lyft.com"
      @token_url = "/oauth/token"
      @authorize_url = "/oauth/authorize"
    end
  end
end
