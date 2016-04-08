module Lyft
  class OAuth2 < ::OAuth2::Client
    attr_accessor :access_token

    def initialize(client_id=Lyft.config.client_id,
                   client_secret=Lyft.config.client_secret,
                   options = {}, &block)

      if client_id.is_a? Hash
        options = client_id
        client_id = Lyft.config.client_id
      end

      options = default_oauth_options(options)

      super client_id, client_secret, options, &block

      @redirect_uri = options[:redirect_uri]

      if self.options[:raise_errors]
        check_credentials!(client_id, client_secret)
      end
    end

    def auth_code_url(options={})
      options = default_auth_code_url_options(options)

      if self.options[:raise_errors]
        check_redirect_uri!(options)
      end

      @redirect_uri = options[:redirect_uri]

      self.auth_code.authorize_url(options)
    end

    def get_access_token(options={})
      tok = self.client_credentials.get_token(options)
      self.access_token = Lyft::AccessToken.new(tok.token,
                                                    tok.expires_in,
                                                    tok.expires_at)
    rescue ::OAuth2::Error => e
      raise OAuthError.new(e.response)
    end

    def get_auth_code_access_token(code=nil, options={})
      check_for_code!(code)
      options = default_access_code_options(options)

      if self.options[:raise_errors]
        check_access_code_url!(options)
      end

      tok = self.auth_code.get_token(code, options)
      self.access_token = Lyft::AccessToken.new(tok.token,
                                                    tok.expires_in,
                                                    tok.expires_at)
      return self.access_token
    rescue ::OAuth2::Error => e
      raise OAuthError.new(e.response)
    end

    private

    def default_access_code_options(custom_options={})
      custom_options ||= {}
      options = {raise_errors: true}

      @redirect_uri = Lyft.config.redirect_uri if @redirect_uri.nil?
      options[:redirect_uri] = @redirect_uri

      options = options.merge custom_options
      return options
    end

    def default_auth_code_url_options(custom_options={})
      custom_options ||= {}
      options = {raise_errors: true}

      if not Lyft.config.redirect_uri.nil?
        options[:redirect_uri] = Lyft.config.redirect_uri
      end
      if not Lyft.config.scope.nil?
        options[:scope] = Lyft.config.scope
      end

      options = options.merge custom_options

      if options[:state].nil?
        options[:state] = generate_csrf_token
      end

      return options
    end

    def generate_csrf_token
      SecureRandom.base64(32)
    end

    def check_access_code_url!(options={})
      check_redirect_uri!(options)
      if options[:redirect_uri] != @redirect_uri
        raise redirect_uri_mismatch
      end
    end

    def check_for_code!(code)
      if code.nil?
        msg = ErrorMessages.no_auth_code
        raise InvalidRequest.new(msg)
      end
    end

    def check_redirect_uri!(options={})
      if options[:redirect_uri].nil?
        raise redirect_uri_error
      end
    end

    def default_oauth_options(custom_options={})
      custom_options ||= {}
      options = {}
      options[:site] = Lyft.config.site
      options[:token_url] = Lyft.config.token_url
      options[:authorize_url] = Lyft.config.authorize_url
      return options.merge custom_options
    end

    def check_credentials!(client_id, client_secret)
      if client_id.nil? or client_secret.nil?
        raise credential_error
      end
    end

    def redirect_uri_error
      InvalidRequest.new ErrorMessages.redirect_uri
    end

    def credential_error
      InvalidRequest.new ErrorMessages.credentials_missing
    end

    def redirect_uri_mismatch
      InvalidRequest.new ErrorMessages.redirect_uri_mismatch
    end
  end
end
