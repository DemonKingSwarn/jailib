operator * :: inline (lhs: Vector2, rhs: float) -> Vector2 {
  return Vector2Scale(lhs, rhs);
}

operator * :: inline (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2Multiply(lhs, rhs);
}

operator + :: inline (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2Add(lhs, rhs);
}

operator - :: inline (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2Subtract(lhs, rhs);
}

#if OS == .LINUX {
  libm :: #library,system,link_always "libm";
  #load "linux.jai";
} else #if OS == .WINDOWS {
  #load "windows.jai";
  libm :: #library,system,link_always "libm";
} else #if OS == .MACOS {
  #load "macos.jai";
}


