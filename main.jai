#import "Basic";
#import "Raylib";

#load "config.jai";
#load "player.jai";

main :: () {
  start();

  while !WindowShouldClose() {
    delta := GetFrameTime();
    update(delta); 
  }

  UnloadTexture(player_texture);
  CloseWindow();
}

// called at the very first frame
start :: () {
  SetTargetFPS(fps);
  InitWindow(width, height, title);
  player_init();
}

// called at every frame
update :: (delta: float) {

  if IsKeyDown(Q_Key) {
    CloseWindow();
  }

  BeginDrawing();
  ClearBackground(BACKGROUND_COLOR);
  defer EndDrawing();

  draw_player();

  player_update(delta);
}
