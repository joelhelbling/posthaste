module Posthaste
  class RequestTemplate
    attr_reader :name, :http_method, :endpoint, :body_template

    def initialize(config)
      @name = config['name']
      @http_method = config['method']
      @endpoint = config['endpoint'] || '/'
      @parameter_defaults = config['parameter_defaults']
      @required_parameters = config['required_parameters']
      @body_template = config['body_template'] || ""
    end

    def header_defaults
      @parameter_defaults&.fetch('header', {})
    end

    def query_string_required
      @required_parameters&.fetch('query_string', [])
    end

    def header_required
      @required_parameters&.fetch('header', [])
    end

    def body_required
      @required_parameters&.fetch('body', [])
    end
  end
end
