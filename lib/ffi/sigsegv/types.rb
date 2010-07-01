require 'ffi'

module FFI
  module SigSEGV
    extend FFI::Library

    callback :sigsegv_handler, [:pointer, :int], :int

    typedef :pointer, :stackoverflow_context

    callback :stackoverflow_handler, [:int, :stackoverflow_context], :void

    callback :sigsegv_area_handler, [:pointer, :pointer], :int
  end
end
