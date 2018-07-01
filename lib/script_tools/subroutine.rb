require "script_tools/control_code"
require "script_tools/subroutine/tools"

module ScriptTools
  class Subroutine
    define_subroutine :Text, 0x0002 do
      followed_by :sequence, length: :variable

      class Chunk
        attr_reader :data

        def initialize
          @data = []
        end

        def to_s
          @data.join
        end
      end

      # Continues reading until it reaches an instruction to terminate
      # the stream.
      def consume stream
        loop do
          bytes = stream.read(2)
          # Is this text or a control code?
          if ControlCode.control_code_map.has_key? bytes[0].ord
            code = ControlCode.control_code_map[bytes[0].ord].new bytes[1].ord
            @data << code

            # Indicates the end of this block of dialogue;
            # other values indicate things like new text boxes within
            # the same dialogue block.
            if code.class == ControlCode::Dialogue && code.value == 0xFF
              break
            end

            next
          end

          # Last portion of the data is a control code, so we need a new text chunk
          if !@data.last.is_a? Chunk
            @data << Chunk.new
          end

          @data.last.data.concat bytes.each_char.to_a
        end
      end
    end

    define_subroutine :Jump, 0x0003 do
      followed_by :integer, length: 2

      # Like the offsets in the table at the beginning of the file,
      # this is a 16-bit big endian integer and needs to be doubled.
      def offset
        ((@data[0].ord << 8) + data[1].ord) * 2
      end
    end

    define_subroutine :EndOfScript, 0x0005 do
      followed_by :nothing
    end

    define_subroutine :Choice, 0x0007
  end
end
