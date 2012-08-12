require 'ffi/sigsegv/library'

module FFI
  module SigSEGV
    @handler = nil

    #
    # Installs a global SIGSEGV handler.
    #
    # @yield [fault_address, serious]
    #   The block will be called when the handler is triggered.
    #
    # @yieldparam [FFI::MemoryPointer] fault_address
    #   The address the Segmentation Fault occurred at.
    #
    # @yieldparam [:stack_overflow, :serious] serious
    #   Indicates the severity of the Segmentation Fault.
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
