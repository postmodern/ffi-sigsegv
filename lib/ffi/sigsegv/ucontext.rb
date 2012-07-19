require 'ffi/sigsegv/types'
require 'ffi/sigsegv/signal_stack'
require 'ffi/sigsegv/mcontext'
require 'ffi/sigsegv/signal_set'
require 'ffi/sigsegv/fpstate'

module FFI
  module SigSEGV
    class UContext < FFI::Struct

      layout :uc_flags, :long,
             :uc_link, :pointer,
             :uc_stack, SignalStack,
             :uc_mcontext, MContext,
             :uc_sigmask, SignalSet,
             :fpregs_mem, FPState

    end
  end
end
