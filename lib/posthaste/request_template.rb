module Posthaste
  class RequestTemplate
    attr_reader :name, :http_method, :endpoint, :body_template

    VALID_METHODS = %w[
      GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE PATCH
    ]

    def initialize(config={})
      @name = config['name']
      @http_method = get_valid_method_from(config['method'])
      @endpoint = config.fetch('endpoint', '/')
      @parameter_defaults = config.fetch('parameter_defaults', {})
      @required_parameters = config.fetch('required_parameters', {})
      @body_template = config.fetch('body_template', '')
    end

    def header_defaults
      @parameter_defaults.fetch('header', {})
    end

    def query_string_required
      @required_parameters.fetch('query_string', [])
    end

    def header_required
      @required_parameters.fetch('header', [])
    end

    def body_required
      @required_parameters.fetch('body', [])
    end

    private

    def get_valid_method_from(method)
      VALID_METHODS.include?(method) ? method : 'GET'
    end
  end
end
