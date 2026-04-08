#import "Basic";
#import "Raylib";

#load "config.jai";
#load "player.jai";

main :: () { 
  SetTargetFPS(fps);
 
  InitWindow(width, height, title);

  anchor_position := Vector2.{width*0.5, height*0.25};
  ball_position := Vector2.{width*0.25, height*0.5};
  ball_velocity := Vector2.{100, 0};
  gravity := Vector2.{0, 1000};

  while !WindowShouldClose() {
    dt := GetFrameTime();
    
    tension_force := anchor_position - ball_position;

    ball_velocity += (gravity + tension_force) * dt;
    new_ball_position := ball_position + ball_velocity * dt;
    
    if new_ball_position.y + radius > height {
      ball_velocity.y *= -1;
    } else {
      ball_position = new_ball_position;
    }

    if IsKeyDown(Q_Key) {
      CloseWindow();
    }

    if IsKeyDown(FullscreenKey) {
      ToggleFullscreen();
    }

    BeginDrawing();
    ClearBackground(BACKGROUND_COLOR);
    DrawLineEx(anchor_position, ball_position, rope_thickness, ROPE_COLOR);
    DrawCircleV(ball_position, radius, FOREGROUND_COLOR);
    DrawCircleV(anchor_position, radius*0.25, ANCHOR_COLOR);
    EndDrawing();
  }  

  CloseWindow();
}
