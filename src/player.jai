
player :: "assets/square.png";

position: Vector2;
rotation : float = 0.0;
scale: float = 0.2;

player_texture: Texture2D;

speed: float = 250;


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

  if DEBUG {
    DrawText(TextFormat("position = %", position), 20, 30, 20, WHITE);
  }

  if IsMouseButtonPressed(xx MouseButton.MOUSE_BUTTON_LEFT) {
    // TODO: implementation of bullet fire 
  }
}
