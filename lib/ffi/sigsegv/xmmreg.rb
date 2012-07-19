require 'ffi'

module FFI
  module SigSEGV
    class XMMReg < FFI::Struct

      layout :element, [:uint32, 4]

    end
  end
end
