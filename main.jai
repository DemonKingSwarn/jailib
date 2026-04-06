#import "Basic";

#load "config.jai";
#load "raylib.jai";

main :: () {
 
  SetTargetFPS(fps);
 
  InitWindow(width, height, title);
  
  while !WindowShouldClose() {
   
    if IsKeyDown(Q_Key) {
      CloseWindow();
    }

    BeginDrawing();
    ClearBackground(0x5A5A5A);
    DrawText("raylib in jai", 190, 200, 20, 0xFFFFFFFF);
    EndDrawing();
  }  

  CloseWindow();

}
