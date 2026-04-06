#import "Basic";
#import "Raylib";

libm :: #library,system,link_always "libm";

#load "config.jai";

BACKGROUND_COLOR :: Color.{r = 0x2B, g = 0x2B, b = 0x2B, a = 0xFF};
FOREGROUND_COLOR :: Color.{r = 0xFF, g = 0x50, b = 0x50, a = 0xFF};

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
    ClearBackground(BACKGROUND_COLOR);
    center := Vector2.{GetScreenWidth() / 2., GetScreenHeight() / 2.};
    DrawCircleV(center, 100, FOREGROUND_COLOR);
    EndDrawing();
  }  

  CloseWindow();

}
