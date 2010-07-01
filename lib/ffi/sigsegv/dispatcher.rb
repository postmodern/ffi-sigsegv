require 'ffi'

module FFI
  module SigSEGV
    class Dispatcher < FFI::Struct

      layout :tree, :pointer

    end
  end
end
