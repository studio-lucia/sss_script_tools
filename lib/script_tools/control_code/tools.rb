module ScriptTools
  class ControlCode
    class BaseControlCode
      class << self
        attr_reader :magic_number
      end

      attr_reader :value

      def initialize value
        @value = value
      end
    end

    class << self
      attr_reader :control_code_map
    end

    @control_codes = []
    @control_code_map = {}

    def self.define_control_code(name, magic_number, &block)
      klass = Class.new(BaseControlCode, &block)
      const_set(name, klass)
      klass.instance_variable_set(:@magic_number, magic_number)

      @control_codes << klass
      @control_code_map[magic_number] = klass
    end
  end
end
