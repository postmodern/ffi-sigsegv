require 'ffi/sigsegv/sigsegv'

require 'ffi'

module FFI
  module SigSEGV
    class Dispatcher < FFI::Struct

      class Handler < Proc
        
        def self.new(&block)
          super do |fault_address,user_arg|
            yield fault_address
          end
        end

      end

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
        if ptr then  super(ptr)
        else         SigSEGV.sigsegv_init(super())
        end

        @handlers = {}
      end

      #
      # Registers a new SIGSEGV handler.
      #
      # @param [Integer] address
      #   The base address.
      #
      # @param [Integer] length
      #   The length of bytes from the base address.
      #
      # @yield [fault_address]
      #   The given block will be passed the fault address, when the dispatcher
      #   calls the handlers.
      #
      # @yieldparam [FFI::MemoryPointer] fault_address
      #   The address the Segmentation Fault occurred at.
      #
      # @return [FFI::MemoryPointer]
      #   The "ticket" to use when unregistering the handler with
      #   {#unregister}.
      #
      def register(address,len,&block)
        handler = Handler.new(&block)
        ticket  = SigSEGV.register(self,address,length,handler,nil)

        @handlers[ticket] = handler
        return handler
      end

      #
      # Unregisters a handler.
      #
      # @param [FFI::MemoryPointer] ticket
      #   The "ticket" returned by {#register}.
      #
      def unregister(ticket)
        SigSEGV.unregister(self,ticket)

        @handlers.delete(ticket)
        return true
      end

      #
      # Triggers all handlers registered to the dispatcher.
      #
      # @param [FFI::MemoryPointer] fault_address
      #   The pointer to the fauly address.
      #
      # @return [Integer]
      #   The return value of the handler. `0` will be returned if no handlers
      #   were called.
      #
      def dispatch(fault_address)
        SigSEGV.sigsegv_dispatch(self,fault_address)
      end

    end
  end
end
