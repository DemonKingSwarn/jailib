enemy :: "assets/square.png";

Enemy :: struct {
    pos:   Vector2;
    rot:   float = 0.0;
    scale: float = 0.2;
}

enemy_texture: Texture2D;

enemy_speed: float = 100;

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
        scale = 0.2
    };
    return enemy;
}

draw_enemy :: (enemy: Enemy) {
    width  := cast(float) enemy_texture.width;
    height := cast(float) enemy_texture.height;

    origin := Vector2.{
        (width  * enemy.scale) / 2,
        (height * enemy.scale) / 2
    };

    DrawTexturePro(
        enemy_texture,
        Rectangle.{0, 0, width, height},
        Rectangle.{enemy.pos.x, enemy.pos.y, width * enemy.scale, height * enemy.scale},
        origin,
        enemy.rot,
        BLUE
    );
}

move_enemy :: (enemy: *Enemy, player_pos: Vector2, delta: float) {
  direction := player_pos - enemy.pos;
  length := Math.sqrt(direction.x * direction.x + direction.y * direction.y);
  if length > 0 {
    dir := Vector2.{direction.x / length, direction.y / length};
    enemy.pos.x += dir.x * enemy_speed * delta;
    enemy.pos.y += dir.y * enemy_speed * delta;
  }
}
