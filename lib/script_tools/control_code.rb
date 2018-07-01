require "script_tools/control_code/tools"

module ScriptTools
  class ControlCode
    define_control_code :Space, 0xF9
    define_control_code :Portrait, 0xFA
    define_control_code :Dialogue, 0xFF
  end
end
