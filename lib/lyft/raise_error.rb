require 'faraday'

module Lyft
  class RaiseError < Faraday::Response::RaiseError
    def on_complete(response)
      status_code = response.status.to_i
      if status_code == 403 && response.body =~ /throttle/i
        raise Lyft::ThrottleError
      else
        super
      end
    end
  end
end

Faraday::Response.register_middleware :lyft_raise_error => Lyft::RaiseError
