module ScriptTools
  class Pointer
    attr_reader :offset

    def initialize(offset:)
      @offset = offset
    end

    def null?; offset == 0; end
  end
end
