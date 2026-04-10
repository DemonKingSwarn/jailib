#import "Basic";
#import "Raylib";

Math :: #import "Math";

#load "config.jai";
#load "src/player.jai";
#load "src/spawner.jai";

main :: () {
  start();

  while !WindowShouldClose() {
    delta := GetFrameTime();
    update(delta); 
  }

  UnloadTexture(player_texture);
  UnloadTexture(enemy_texture);
  CloseWindow();
}

// called at the very first frame
start :: () {
  SetTargetFPS(fps);
  InitWindow(width, height, title);
  HideCursor();
  player_init();
  init_spawner();
}

// called at every frame
update :: (delta: float) {

  if IsKeyDown(xx KeyboardKey.Q) {
    CloseWindow();
  }

  BeginDrawing();
  ClearBackground(BLACK);
  defer EndDrawing();

  if DEBUG {
    DrawText(TextFormat("fps = %", GetFPS()), 20, 10, 20, WHITE);
  }

  draw_player();
  draw_spawner();
  spawn(delta);
  update_spawner(position, delta);
  player_update(delta);
}
