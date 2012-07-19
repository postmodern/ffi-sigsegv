require 'ffi'

module FFI
  module SigSEGV
    class SignalSet < FFI::Struct

      NWORDS = (1024 / (8 * Type::ULONG.size))

      layout :val, [:long, NWORDS]

    end
  end
end
