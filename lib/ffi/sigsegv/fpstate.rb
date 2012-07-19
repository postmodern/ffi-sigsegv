require 'ffi/sigsegv/types'
require 'ffi/sigsegv/fpreg'
require 'ffi/sigsegv/fpxreg'
require 'ffi/sigsegv/xmmreg'

module FFI
  module SigSEGV
    class FPState < FFI::Struct

      case Platform::ADDRESS_SIZE
      when 64
        layout :cwd, :uint16,
               :swd, :uint16,
               :ftw, :uint16,
               :fop, :uint16,
               :rip, :uint64,
               :rdp, :uint64,
               :mxcsr, :uint32,
               :mxcr_mask, :uint32,
               :st, [FPXReg, 8],
               :xmm, [XMMReg, 16],
               :padding, [:uint32, 24]
      when 32
        layout :cw, :long,
               :sw, :long,
               :tag, :long,
               :ipoff, :long,
               :cssel, :long,
               :dataoff, :long,
               :datasel, :long,
               :st, [FPReg, 8],
               :status, :int
      else
        raise(NotImplementedError,"ffi-sigsegv does not support address-size: #{Platform::ADDRESS_SIZE}")
      end

    end
  end
end
