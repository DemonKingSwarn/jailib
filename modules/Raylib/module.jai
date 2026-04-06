#if OS == .LINUX {
  #load "linux.jai";
  libm :: #library,system,link_always "libm";
} else {
  #assert false, "Your OS is not supported yet";
}
