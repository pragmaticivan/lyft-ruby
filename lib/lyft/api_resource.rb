module Lyft

  class APIResource

    def initialize(connection)
      @connection = connection
    end

    protected ############################################################

    def get(path, options={})
      url, params, headers = prepare_connection_params(path, options)
      puts url
      puts params
      puts headers
      response = @connection.get(url, params, headers)

      return Mash.from_json(response.body)
    end

    def post(path=nil, body=nil, headers=nil, &block)
      @connection.post(prepend_prefix(path), body, headers, &block)
    end

    def put(path=nil, body=nil, headers=nil, &block)
      @connection.put(prepend_prefix(path), body, headers, &block)
    end

    def delete(path=nil, params=nil, headers=nil, &block)
      @connection.delete(prepend_prefix(path), params, headers, &block)
    end

    def deprecated
      Lyft::Deprecated.new(Lyft::ErrorMessages.deprecated)
    end

    private ##############################################################

    def prepend_prefix(path)
      return @connection.path_prefix + path
    end

    def prepare_connection_params(path, options)
      path = prepend_prefix(path)
      path += generate_field_selectors(options)

      headers = options.delete(:headers) || {}

      params = format_options_for_query(options)

      return [path, params, headers]
    end

    # Dasherizes the param keys
    def format_options_for_query(options)
      options.reduce({}) do |list, kv|
        key, value = kv.first.to_s.gsub("_","-"), kv.last
        list[key]  = value
        list
      end
    end

    def generate_field_selectors(options)
      default = Lyft.config.default_profile_fields || {}
      fields = options.delete(:fields) || default

      if options.delete(:public)
        return ":public"
      elsif fields.empty?
        return ""
      else
        return ":(#{build_fields_params(fields)})"
      end
    end

    def build_fields_params(fields)
      if fields.is_a?(Hash) && !fields.empty?
        fields.map {|i,v| "#{i}:(#{build_fields_params(v)})" }.join(',')
      elsif fields.respond_to?(:each)
        fields.map {|field| build_fields_params(field) }.join(',')
      else
        fields.to_s.gsub("_", "-")
      end
    end

  end
end
