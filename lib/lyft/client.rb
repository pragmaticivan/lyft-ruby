module Lyft
  class Client < NetHTTPClient
    def initialize(options={})
      [ :api_key, :api_secret ].each do |opt|
        raise unless options.has_key? opt
      end
      @api_key = options[:api_key]
      @api_secret = options[:api_secret]
      @api_uri = URI.parse(options[:api_url] || Lyft::BASE_URL)
      super(@api_uri, options)
    end
  end
  class OAuthClient < NetHTTPClient
    attr_accessor :access_token, :refresh_token
    def initialize(options={})
      raise unless options.has_key? :access_token
      @access_token = options[:access_token]
      @oauth_uri = URI.parse(options[:api_url] || Lyft::BASE_URL)
      super(@oauth_uri, options)
    end

    def auth_headers(method, path, body)
      { 'Authorization' => "Bearer #{@access_token}"}
    end

    def authorize!(redirect_url, params = {})
      raise NotImplementedError
    end
  end
end
