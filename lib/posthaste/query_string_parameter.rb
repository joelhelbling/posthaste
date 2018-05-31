module Posthaste
  class QueryStringParameter < Parameter

    def type
      :query_string_parameter
    end

    def to_s
      "#{name}=#{escaped_value}"
    end

    private

    def escaped_value
      URI.escape(value.to_s, ' =?&;')
    end
  end
end
