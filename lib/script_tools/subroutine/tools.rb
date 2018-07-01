module ScriptTools
  class Subroutine
    class BaseSubroutine
      attr_reader :data

      class << self
        attr_reader :magic_number
        attr_reader :followed_by_type
        attr_reader :followed_by_length

        def followed_by(value, length: nil)
          valid_values = [:nothing, :integer, :sequence]
          raise ArgumentError, "Invalid value: #{value}" unless valid_values.include? value

          @followed_by_type = value
          @followed_by_length = length unless length.nil?
        end
      end

      def initialize
        @data = []
      end

      # Consume a set of bytes from the stream.
      # This assumes that the magic number has already been read,
      # and the remaining bytes are positioned immediately after the magic number.
      # This implements generic handlers for integers and null values;
      # sequence handling cannot be done generically, so this is overridden
      # in subclasses which need to do their own sequence handling.
      def consume stream
        return if self.class.followed_by_type == :nothing
        return if self.class.followed_by_type.nil? # unknown

        # We know a specific length to read, so read just that and return
        if self.class.followed_by_type == :integer
          @data = stream.read(self.class.followed_by_length)
          return
        end

        raise NotImplementedError, "Sequence handling cannot be performed generically"
      end
    end

    # Represents an undocumented subroutine
    class Unknown
      def initialize(magic_number:)
        @magic_number = magic_number
        @data = []
      end
    end

    class << self
      attr_reader :subroutines
      attr_reader :subroutine_map
    end

    @subroutines = []
    @subroutine_map = {}

    def self.define_subroutine(name, magic_number, &block)
      klass = Class.new(BaseSubroutine, &block)
      const_set(name, klass)
      klass.instance_variable_set(:@magic_number, magic_number)

      @subroutines << klass
      @subroutine_map[magic_number] = klass
    end
  end
end
