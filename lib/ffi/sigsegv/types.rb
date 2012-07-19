require 'ffi'

module FFI
  module SigSEGV
    extend FFI::Library

    case Platform::ADDRESS_SIZE
    when 64
      typedef :long, :greg_t

      NGREG = 23

      enum :regs, [
        :r8,
        :r9,
        :r10,
        :r11,
        :r12,
        :r13,
        :r14,
        :r15,
        :rdi,
        :rsi,
        :rbp,
        :rbx,
        :rdx,
        :rax,
        :rcx,
        :rsp,
        :rip,
        :efl,
        :csgsfs,		# actually short cs, gs, fs, __pad0.
        :err,
        :trapno,
        :oldmask,
        :cr2
      ]
    when 32
      typedef :int, :greg_t

      NGREG = 19

      enum :regs, [
        :gs,
        :fs,
        :es,
        :ds,
        :edi,
        :esi,
        :ebp,
        :esp,
        :ebx,
        :edx,
        :ecx,
        :eax,
        :trapno,
        :err,
        :eip,
        :cs,
        :efl,
        :uesp,
        :ss
      ]
    else
      raise(NotImplementedError,"ffi-sigsegv does not support address-size: #{Platform::ADDRESS_SIZE}")
    end

    GRegSet = [:greg_t, NGREG]

    typedef :pointer, :fpregset_t
    typedef :pointer, :mcontext_t
    typedef :pointer, :ucontext_t

    callback :sigsegv_handler, [:pointer, :int], :int

    typedef :pointer, :stackoverflow_context

    callback :stackoverflow_handler, [:int, :stackoverflow_context], :void

    callback :sigsegv_area_handler, [:pointer, :pointer], :int
  end
end
