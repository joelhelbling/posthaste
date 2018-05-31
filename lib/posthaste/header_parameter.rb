module Posthaste
  class HeaderParameter < Parameter
    def type
      :header_parameter
    end

    def to_s
      "#{name}:#{value}"
    end
  end
end
