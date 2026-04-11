#import "Random";

#load "enemy.jai";

spawn_points: [4] Vector2 = .[TOP_LEFT, TOP_RIGHT, BOT_LEFT, BOT_RIGHT];

enemy_spawn_timer: float = 1.20;
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
    if !it.active continue;
    if enemy_is_dead(it) continue;
    draw_enemy(it);
  }
}

update_spawner :: (player_pos: Vector2, delta: float) {
  for *enemies {
    if !it.active continue;
    if enemy_is_dead(it.*) continue;
    move_enemy(it, player_pos, delta);
  }
}

circles_overlap :: (a: Vector2, ar: float, b: Vector2, br: float) -> bool {
  dx := a.x - b.x;
  dy := a.y - b.y;
  r := ar + br;
  return (dx * dx + dy * dy) <= (r * r);
}

resolve_player_enemy_collisions :: (delta: float) {
  for enemies {
    if !it.active continue;
    if enemy_is_dead(it) continue;

    if circles_overlap(position, player_radius(), it.pos, enemy_radius(it)) {
      player_take_damage(35.0 * delta);
    }
  }
}

resolve_bullet_enemy_collisions :: () {
  for *bullets {
    bullet := it;
    if !bullet.active continue;

    for *enemies {
      enemy := it;
      if !enemy.active continue;
      if enemy_is_dead(enemy.*) continue;

      if circles_overlap(bullet.pos, bullet_radius(bullet), enemy.pos, enemy_radius(enemy.*)) {
        enemy_take_damage(enemy, damage);
        bullet.active = false;

        if enemy_is_dead(enemy.*) {
          enemy.active = false;
        }
        break;
      }
    }
  }
}

remove_dead_enemies :: () {
  i: int = 0;
  while i < enemies.count {
    if enemies[i].active && !enemy_is_dead(enemies[i]) {
      i += 1;
      continue;
    }

    enemies[i] = enemies[enemies.count - 1];
    enemies.count -= 1;
  }
}
