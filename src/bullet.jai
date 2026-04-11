bullet :: "assets/square.png";

Bullet :: struct {
    pos:   Vector2;
    dir:   Vector2;
    rot:   float = 0.0;
    scale: float = 0.08;
    age:   float = 0.0;
    active: bool = false;
}

MAX_BULLETS :: 256;
DEFAULT_BULLET_BURST :: 5;

bullet_texture: Texture2D;
bullets: [MAX_BULLETS] Bullet;

BULLET_SPEED: float : 700.0;
BULLET_LIFETIME: float : 5.0;

damage: float = 12;

bullet_radius :: (bullet: *Bullet) -> float {
    width  := cast(float) bullet_texture.width;
    height := cast(float) bullet_texture.height;
    if width < height return (width * bullet.scale) / 2.0;
    return (height * bullet.scale) / 2.0;
}

normalize_or_right :: (value: Vector2) -> Vector2 {
    length_sq := value.x * value.x + value.y * value.y;
    if length_sq <= 0.0001 {
        return Vector2.{1, 0};
    }

    length := Math.sqrt(length_sq);
    return Vector2.{value.x / length, value.y / length};
}

add_bullet_to_pool :: (spawn_pos: Vector2, direction: Vector2) {
    for *bullets {
        if it.active continue;

        it.pos    = spawn_pos;
        it.dir    = normalize_or_right(direction);
        it.rot    = cast(float) (Math.atan2(it.dir.y, it.dir.x) * RAD2DEG);
        it.scale  = 0.06;
        it.age    = 0.0;
        it.active = true;
        return;
    }
}

spawn_bullet :: (spawn_pos: Vector2, target_pos: Vector2) {
    direction := target_pos - spawn_pos;
    add_bullet_to_pool(spawn_pos, direction);
}

spawn_bullets :: (spawn_pos: Vector2, target_pos: Vector2, count := DEFAULT_BULLET_BURST, spread_degrees: float = 24.0) {
    if count <= 1 {
        spawn_bullet(spawn_pos, target_pos);
        return;
    }

    base_direction := normalize_or_right(target_pos - spawn_pos);
    base_angle := Math.atan2(base_direction.y, base_direction.x);

    spread_radians := spread_degrees * DEG2RAD;
    step := spread_radians / cast(float) (count - 1);
    start := -spread_radians / 2.0;

    for 0..count {
        angle_offset := start + step * cast(float) it;
        angle := base_angle + angle_offset;
        direction := Vector2.{cast(float) Math.cos(angle), cast(float) Math.sin(angle)};
        add_bullet_to_pool(spawn_pos, direction);
    }
}

bullet_load_texture :: () {
    if bullet_texture.id != 0 return;

    img := LoadImage(bullet);
    ImageFormat(*img, xx PixelFormat.PIXELFORMAT_UNCOMPRESSED_R8G8B8A8);
    bullet_texture = LoadTextureFromImage(img);
    UnloadImage(img);
}

draw_bullets :: () {
    width  := cast(float) bullet_texture.width;
    height := cast(float) bullet_texture.height;

    for bullets {
        if !it.active continue;

        origin := Vector2.{
            (width  * it.scale) / 2,
            (height * it.scale) / 2
        };

        DrawTexturePro(
            bullet_texture,
            Rectangle.{0, 0, width, height},
            Rectangle.{it.pos.x, it.pos.y, width * it.scale, height * it.scale},
            origin,
            it.rot,
            WHITE
        );
    }
}

update_bullets :: (delta: float) {
  for *bullets {
    if !it.active continue;

    it.pos.x += it.dir.x * BULLET_SPEED * delta;
    it.pos.y += it.dir.y * BULLET_SPEED * delta;
    it.age += delta;

    if it.age >= BULLET_LIFETIME {
      it.active = false;
    }
  }
}
