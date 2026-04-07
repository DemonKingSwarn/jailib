#if OS == .LINUX {
  #load "linux.jai";
  libm :: #library,system,link_always "libm";
} else if OS == .WINDOWS {
  #load "windows.jai";
  libm :: #library,system,link_always "libm";
} else {
  #load "macos.jai";
}
