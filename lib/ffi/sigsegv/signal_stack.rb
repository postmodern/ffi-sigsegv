require 'ffi'

module FFI
  module SigSEGV
    class SignalStack < FFI::Struct

      layout :ss_sp, :pointer,
             :ss_flags, :int,
             :ss_size, :size_t

    end
  end
end
