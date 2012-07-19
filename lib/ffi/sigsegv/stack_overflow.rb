require 'ffi/sigsegv/sigsegv'

module FFI
  module SigSEGV
    module StackOverflow

      SIGSTKSZ = (16 * 1024)

      @handler     = nil
      @extra_stack = nil

      #
      # Installs a global Stack Overflow handler.
      #
      # @param [Integer] extra_stack_size
      #   The size of the extra stack space, to be used when the handler is
      #   called.
      #
      # @return [true]
      #   Success.
      #
      # @raise
      #   The system does not support catching stack overflows.
      #
      def self.install(extra_stack_size=SIGSTKSZ,&block)
        @handler     = block
        @extra_stack = FFI::Buffer.new(extra_stack_size)

        unless SigSEGV.stackoverflow_install_handler(@extra_stack,extra_stack_size,block) == 0
          raise("system does not support catching stack overflows")
        end

        return true
      end

      #
      # Uninstalls the global Stack Overflow handler.
      #
      def self.deinstall
        SigSEGV.stackoverflow_deinstall_handler

        @handler     = nil
        @extra_stack = nil
        return true
      end

    end
  end
end
