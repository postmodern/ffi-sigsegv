require 'ffi/sigsegv/types'

module FFI
  module SigSEGV
    class MContext < FFI::Struct

      case Platform::ADDRESS_SIZE
      when 64
        layout :gregs,    GRegSet,
               :fpregs,   :fpregset_t,
               :reserved, [:ulong, 8]
      when 32
        layout :gregs,   GRegSet,
               :fpregs,  :fpregset_t,
               :oldmask, :long,
               :cr2,     :long
      else
        raise(NotImplementedError,"ffi-sigsegv does not support address-size: #{Platform::ADDRESS_SIZE}")
      end

    end
  end
end
