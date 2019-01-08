module ScriptTools
  class ControlCode
    class BaseControlCode
      class << self
        # Returns this class's magic number.
        attr_reader :magic_number
      end

      # The 8-bit integer value for this control code.
      # For example, given the control code 0xFF02,
      # the value would be 0x02.
      attr_reader :value

      def initialize value
        @value = value
      end

      def to_s
        [self.class.magic_number.chr, value.chr].join
      end
    end

    class << self
      # Contains a mapping between 8-bit control code integers
      # and the class that represents them.
      attr_reader :control_code_map
    end

    @control_codes = []
    @control_code_map = {}

    # Defines a new class representing a control code.
    # magic_number is the 8-bit integer that identifies the beginning
    # of a control code, such as 0xFF.
    # A block can be passed to define additional methods or to
    # subclass methods.
    def self.define_control_code(name, magic_number, &block)
      klass = Class.new(BaseControlCode, &block)
      const_set(name, klass)
      klass.instance_variable_set(:@magic_number, magic_number)

      @control_codes << klass
      @control_code_map[magic_number] = klass
    end
  end
end
