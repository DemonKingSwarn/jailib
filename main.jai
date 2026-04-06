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

    BeginDrawing();
    ClearBackground(.{r = 0xFF, a = 0xFF});
    //DrawText("raylib in jai", 190, 200, 20, RAYWHITE);
    EndDrawing();
  }  

  CloseWindow();

}
