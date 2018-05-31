module Posthaste
  class Parameter
    attr_reader :name
    attr_accessor :value

    def initialize(name:, value: nil, required: false)
      @name = name
      @value = value
      @required = required
    end

    def required?
      @required
    end

    def satisfied?
      value || ! required?
    end

    def to_s
      inspect
    end

    def type
      :generic_parameter
    end
  end
end
