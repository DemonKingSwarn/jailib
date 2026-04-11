score: int = 0;


game_over :: () {
  time_scale = 0.0;
  message := TextFormat("Game Over");
  font_size: s32 = 80;
  text_width := MeasureText(message, font_size);
  x := cast(s32) CENTER.x - (text_width / 2);
  y := cast(s32) CENTER.y - (font_size / 2);
  DrawText(message, x, y, font_size, WHITE);
}

score_manager :: (new_score: int) {
  score = new_score;
}

draw_score :: () {
  DrawText(TextFormat("score = %", score), 20, 50, 40, WHITE);
}
