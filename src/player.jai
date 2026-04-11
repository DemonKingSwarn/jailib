
player :: "assets/square.png";

position: Vector2;
rotation : float = 0.0;
scale: float = 0.2;

player_texture: Texture2D;

speed: float = 250;

player_max_health: float = 100;
health: float = 100;

player_radius :: () -> float {
  width  := cast(float) player_texture.width;
  height := cast(float) player_texture.height;
  if width < height return (width * scale) / 2.0;
  return (height * scale) / 2.0;
}

player_take_damage :: (amount: float) {
  health -= amount;
  if health < 0 {
    health = 0;
  }
}

draw_player_health_bar :: () {
  green := Color.{r = 0x00, g = 0xD0, b = 0x40, a = 0xFF};
  bar_width: float = 380;
  bar_height: float = 24;
  border_size: float = 4;
  x := (cast(float) width - bar_width) / 2.0;
  y: float = 24;

  DrawTexturePro(
    player_texture,
    Rectangle.{0, 0, cast(float) player_texture.width, cast(float) player_texture.height},
    Rectangle.{x - border_size, y - border_size, bar_width + border_size * 2.0, bar_height + border_size * 2.0},
    Vector2.{0, 0},
    0,
    WHITE
  );

  fill_ratio := health / player_max_health;
  if fill_ratio < 0 fill_ratio = 0;
  if fill_ratio > 1 fill_ratio = 1;

  DrawTexturePro(
    player_texture,
    Rectangle.{0, 0, cast(float) player_texture.width, cast(float) player_texture.height},
    Rectangle.{x, y, bar_width * fill_ratio, bar_height},
    Vector2.{0, 0},
    0,
    green
  );
}

player_init :: () {
  position.x = CENTER.x;
  position.y = CENTER.y;
  
  playerImg := LoadImage(player);
  
  ImageFormat(*playerImg, xx PixelFormat.PIXELFORMAT_UNCOMPRESSED_R8G8B8A8);
  player_texture = LoadTextureFromImage(playerImg);
  UnloadImage(playerImg);
}

draw_player :: () {
  origin := Vector2.{ (player_texture.width * scale) / 2, (player_texture.height * scale) / 2};

  DrawTexturePro(
    player_texture, 
    Rectangle.{0, 0, cast(float)player_texture.width, cast(float)player_texture.height},
    Rectangle.{position.x, position.y, player_texture.width * scale, player_texture.height * scale},
    origin, 
    rotation, 
    LIGHTRED);
}

player_update :: (delta: float) {
  if IsKeyDown(xx KeyboardKey.W) position.y -= speed * delta;   
  if IsKeyDown(xx KeyboardKey.S) position.y += speed * delta;   
  if IsKeyDown(xx KeyboardKey.A) position.x -= speed * delta;   
  if IsKeyDown(xx KeyboardKey.D) position.x += speed * delta;

  half_w := (cast(float) player_texture.width * scale) / 2.0;
  half_h := (cast(float) player_texture.height * scale) / 2.0;

  if position.x < half_w position.x = half_w;
  if position.x > cast(float) width - half_w position.x = cast(float) width - half_w;
  if position.y < half_h position.y = half_h;
  if position.y > cast(float) height - half_h position.y = cast(float) height - half_h;

  if DEBUG {
    DrawText(TextFormat("position = %", position), 20, 30, 20, WHITE);
  }

  if IsMouseButtonPressed(xx MouseButton.MOUSE_BUTTON_LEFT) {
    mouse := Vector2.{cast(float) GetMouseX(), cast(float) GetMouseY()};
    spawn_bullet(position, mouse);
  }

  if health == 0 {
    game_over();
  }
}
