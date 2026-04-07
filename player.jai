
PLAYER_COLOR :: Color.{r = 0xFF, g = 0xFF, b = 0xFF, a = 0xFF};

position :: struct {
  posX: s32;
  posY: s32;
}

rotation : float = 0.0;
scale : float = 0.5;

draw_player :: () {
  playerImg := LoadImage("assets/square.png");
  texture := LoadTextureFromImage(playerImg);
  UnloadImage(playerImg);
  
  src := Rectangle.{0, 0, cast(float)texture.width, cast(float)texture.height};
  dst := Rectangle.{cast(float)GetScreenWidth() / 2, cast(float)GetScreenHeight() / 2, texture.width * scale, texture.height * scale};
  origin := Vector2.{texture.width * scale / 2, texture.height * scale / 2};
  
  DrawTexturePro(texture, src, dst, origin, rotation, PLAYER_COLOR);
  UnloadTexture(texture);
}
