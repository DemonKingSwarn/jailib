#import "Basic";

#load "raylib.jai";

main :: () {
  InitWindow(1280, 720, "ray window");
  while !WindowShouldClose() {
    BeginDrawing();
    ClearBackground(0x5A5A5A);
    DrawText("raylib in jai", 190, 200, 20, 0xFFFFFFFF);
    EndDrawing();
  }
  CloseWindow();
}
