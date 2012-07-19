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

    @handler = nil

    #
    # Installs a global SIGSEGV handler.
    #
    # @yield [fault_address, serious]
    #   The block will be called when the handler is triggered.
    #
    # @yieldparam [FFI::MemoryPointer] fault_address
    #
    # @yieldparam [Integer] serious
    #   Indicates the seriously of the Segmentation Fault:
    #
    #   * `0` - possible stack overflow.
    #   * `1` - serious fault.
    #
    # @return [true]
    #
    # @raise
    #   The system does not support SIGSEGV.
    #
    def self.install(&block)
      @handler = block

      unless sigsegv_install_handler(block) == 0
        raise("SIGSEGV not supported")
      end

      return true
    end

    #
    # Uninstalls the global SIGSEGV handler.
    #
    def self.deinstall
      sigsegv_deinstall_handler

      @handler = nil
      return true
    end
  end
end
