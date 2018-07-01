require "script_tools/pointer"

module ScriptTools
  class HeaderParser
    def initialize(stream:)
      @stream = stream.clone
    end

    # Parses the first 0x800 bytes of the stream and returns an array
    # containing 16-bit pointers to the beginning of a subroutine.
    # Some of these are null pointers, e.g. 
    def parse
      @stream.seek(0, IO::SEEK_SET)
      @stream.read(0x800).each_byte.each_slice(2).map do |a, b|
        value = (a << 8) + b

        # Pointer value is double the listed offset ¯\_(ツ)_/¯
        Pointer.new offset: value * 2
      end
    end
  end
end
