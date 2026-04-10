#import "Random";

#load "enemy.jai";

spawn_points: [4] Vector2 = .[TOP_LEFT, TOP_RIGHT, BOT_LEFT, BOT_RIGHT];

enemy_spawn_timer: float = 0.25;
time_to_spawn: float;

enemies: [..] Enemy;

init_spawner :: () {
  enemy_load_texture();
}

spawn :: (delta: float) {
  time_to_spawn += delta;
  if time_to_spawn >= enemy_spawn_timer {
    random_index := cast(int)random_get_within_range(0, spawn_points.count);
    array_add(*enemies, spawn_enemy(spawn_points[random_index]));
    time_to_spawn = 0;
  }
}

draw_spawner :: () {
  for enemies {
    draw_enemy(it);
  }
}

update_spawner :: (player_pos: Vector2, delta: float) {
  for *enemies {
    move_enemy(it, player_pos, delta);
  }
}
