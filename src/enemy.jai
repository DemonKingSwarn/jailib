enemy :: "assets/square.png";

Enemy :: struct {
    pos:   Vector2;
    rot:   float = 0.0;
    scale: float = 0.2;
    health: float;
    active: bool;
    hit_flash_timer: float;
}

enemy_texture: Texture2D;

enemy_speed: float = 100;

enemy_health: float = 50;
enemy_hit_flash_duration: float = 0.08;

player_score: int;

enemy_radius :: (enemy: Enemy) -> float {
    width  := cast(float) enemy_texture.width;
    height := cast(float) enemy_texture.height;
    if width < height return (width * enemy.scale) / 2.0;
    return (height * enemy.scale) / 2.0;
}

enemy_load_texture :: () {
    if enemy_texture.id != 0 return;

    img := LoadImage(enemy);
    ImageFormat(*img, xx PixelFormat.PIXELFORMAT_UNCOMPRESSED_R8G8B8A8);
    enemy_texture = LoadTextureFromImage(img);
    UnloadImage(img);
}

spawn_enemy :: (center: Vector2) -> Enemy {
    enemy := Enemy.{
        pos   = center,
        scale = 0.2,
        health = enemy_health,
        active = true,
        hit_flash_timer = 0.0
    };
    return enemy;
}

enemy_take_damage :: (enemy: *Enemy, amount: float) {
    enemy.health -= amount;
    enemy.hit_flash_timer = enemy_hit_flash_duration;
    if enemy.health <= 0 {
        enemy.health = 0;
        enemy.active = false;
        player_score += 1;
        score_manager(player_score);
    }
}

enemy_is_dead :: (enemy: Enemy) -> bool {
  return enemy.health <= 0;
}

draw_enemy :: (enemy: Enemy) {
    width  := cast(float) enemy_texture.width;
    height := cast(float) enemy_texture.height;

    origin := Vector2.{
        (width  * enemy.scale) / 2,
        (height * enemy.scale) / 2
    };

    tint := BLUE;
    if enemy.hit_flash_timer > 0 {
        tint = WHITE;
    }

    DrawTexturePro(
        enemy_texture,
        Rectangle.{0, 0, width, height},
        Rectangle.{enemy.pos.x, enemy.pos.y, width * enemy.scale, height * enemy.scale},
        origin,
        enemy.rot,
        tint
    );
}

move_enemy :: (enemy: *Enemy, player_pos: Vector2, delta: float) {
  if enemy.hit_flash_timer > 0 {
    enemy.hit_flash_timer -= delta;
    if enemy.hit_flash_timer < 0 {
      enemy.hit_flash_timer = 0;
    }
  }

  direction := player_pos - enemy.pos;
  length := Math.sqrt(direction.x * direction.x + direction.y * direction.y);
  if length > 0 {
    dir := Vector2.{direction.x / length, direction.y / length};
    enemy.pos.x += dir.x * enemy_speed * delta;
    enemy.pos.y += dir.y * enemy_speed * delta;
  }
}
