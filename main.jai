#import "Basic";
#import "Raylib";

Math :: #import "Math";

#load "config.jai";
#load "src/game_manager.jai";
#load "src/player.jai";
#load "src/spawner.jai";
#load "src/bullet.jai";

time_scale: float = 1.0;

main :: () {
  start();

  while !WindowShouldClose() {
    delta := GetFrameTime() * time_scale;
    update(delta); 
  }

  UnloadTexture(player_texture);
  UnloadTexture(enemy_texture);
  UnloadTexture(bullet_texture);
  CloseWindow();
}

// called at the very first frame
start :: () {
  SetTargetFPS(fps);
  InitWindow(width, height, title);
  bullet_load_texture();
  init_spawner();
  player_init();
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

  draw_score();
  draw_player_health_bar();

  draw_player();
  draw_bullets();
  draw_spawner();
  spawn(delta);
  update_spawner(position, delta);
  resolve_bullet_enemy_collisions();
  resolve_player_enemy_collisions(delta);
  remove_dead_enemies();
  player_update(delta);
  update_bullets(delta);
}
