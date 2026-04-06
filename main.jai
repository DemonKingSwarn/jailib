#import "Basic";

libm :: #library,system,link_always "libm";

#load "config.jai";
#load "raylib.jai";

main :: () {
 
  SetTargetFPS(fps);
 
  InitWindow(width, height, title);
  
  while !WindowShouldClose() {
   
    if IsKeyDown(Q_Key) {
      CloseWindow();
    }

    if IsKeyDown(FullscreenKey) {
      ToggleFullscreen();
    }

    //key := GetKeyPressed();
    //print("%\n", key);

    BeginDrawing();
    ClearBackground(.{r = 0x2B, g = 0x2B, b = 0x2B, a = 0xFF});
    EndDrawing();
  }  

  CloseWindow();

}
