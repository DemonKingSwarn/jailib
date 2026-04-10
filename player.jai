
PLAYER_COLOR :: Color.{r = 0xFF, g = 0x50, b = 0x50, a = 0xFF};
player :: "assets/square.png";

position: Vector2;
rotation : float = 0.0;
scale: float = 0.2;

player_texture: Texture2D;

speed: float = 250;


player_init :: () {
  position.x = cast(float)width/2;
  position.y = cast(float)height/2;
  
  playerImg := LoadImage(player);
  
  ImageFormat(*playerImg, 7);
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
    PLAYER_COLOR);
}

player_update :: (delta: float) {
  if IsKeyDown(W_Key) position.y -= speed * delta;   
  if IsKeyDown(S_Key) position.y += speed * delta;   
  if IsKeyDown(A_Key) position.x -= speed * delta;   
  if IsKeyDown(D_Key) position.x += speed * delta;

  if DEBUG {
    DrawText(TextFormat("position = %", position), 20, 30, 20, WHITE);
  }

  if IsMouseButtonPressed(0) {
    // TODO: implementation of bullet fire 
  }
}
