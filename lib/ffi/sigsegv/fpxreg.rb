require 'ffi'

module FFI
  module SigSEGV
    class FPXReg < FFI::Struct

      layout :significand, [:short, 4],
             :exponent, :short,
             :padding, [:short, 3]

    end
  end
end
