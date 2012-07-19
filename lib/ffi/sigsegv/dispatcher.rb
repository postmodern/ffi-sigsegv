require 'ffi/sigsegv/sigsegv'

require 'ffi'

module FFI
  module SigSEGV
    class Dispatcher < FFI::Struct

      layout :tree, :pointer

      #
      # Initializes a new SigSEGV dispatcher.
      #
      # @param [FFI::Pointer] ptr
      #   Optional pointer to an existing dispatcher.
      #
      # @note
      #   If no `ptr` is given, the dispatcher will be initialized by calling
      #   `sigsegv_init`.
      #
      def initialize(ptr=nil)
        if ptr
          super(ptr)
        else
          SigSEGV.sigsegv_init(super())
        end
      end

    end
  end
end
