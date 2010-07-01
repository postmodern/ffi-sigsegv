require 'spec_helper'
require 'ffi/sigsegv/sigsegv'

describe SigSEGV do
  it "should have a libsigsegv version" do
    SigSEGV.libsigsegv_version.should > 0
  end
end
