require 'ffi/sigsegv/types'
require 'ffi/sigsegv/ucontext'

require 'ffi'

module FFI
  module SigSEGV
    extend FFI::Library

    ffi_lib 'sigsegv'

    attach_variable :libsigsegv_version, :int

    attach_function :sigsegv_install_handler, [:sigsegv_handler], :int
    attach_function :sigsegv_deinstall_handler, [], :void

    if self.libsigsegv_version >= 0x0206
      callback :sigsegv_continuation, [:pointer, :pointer, :pointer], :void

      attach_function :sigsegv_leave_handler, [:sigsegv_continuation, :pointer, :pointer, :pointer], :int
    else
      attach_function :sigsegv_leave_handler, [], :void
    end

    attach_function :stackoverflow_install_handler, [:stackoverflow_handler,:pointer, :ulong], :int
    attach_function :stackoverflow_deinstall_handler, [], :void

    attach_function :sigsegv_init, [:pointer], :void
    attach_function :sigsegv_register, [:pointer, :pointer, :ulong, :sigsegv_area_handler, :pointer], :pointer
    attach_function :sigsegv_unregister, [:pointer, :pointer], :void
    attach_function :sigsegv_dispatch, [:pointer, :pointer], :int
  end
end
