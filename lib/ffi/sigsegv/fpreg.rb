require 'ffi'

module FFI
  module SigSEGV
    class FPReg < FFI::Struct

      layout :significand, [:short, 4],
             :exponent, :short

    end
  end
end
