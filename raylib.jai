#import "Math";

libm :: #library,system,link_always "libm";
ray :: #library "libraylib";

InitWindow :: (width: s32, height: s32, title: *u8) #foreign ray;
WindowShouldClose :: () -> bool #foreign ray;
BeginDrawing :: () #foreign ray;
EndDrawing :: () #foreign ray;
CloseWindow :: () #foreign ray;
ClearBackground :: (color: u32) #foreign ray;
ToggleFullscreen :: () #foreign ray;
DrawText :: (text: *u8, posX: s32, posY: s32, fontSize: s32, color: u32) #foreign ray;
ShowCursor :: () #foreign ray;
HideCursor :: () #foreign ray;
SetTargetFPS :: (fps: s32) #foreign ray;
GetTime :: () #foreign ray;
GetFPS :: () #foreign ray;
GetFrameTime :: () -> float #foreign ray;

// input
IsKeyPressed :: (key: s32) -> bool #foreign ray;
IsKeyPressedRepeat :: (key: s32) -> bool #foreign ray;
IsKeyDown :: (key: s32) -> bool #foreign ray;
IsKeyReleased :: (key: s32) -> bool #foreign ray;
IsKeyUp :: (key: s32) -> bool #foreign ray;
GetKeyPressed :: () -> int #foreign ray;
GetCharPressed :: () -> int #foreign ray;
SetExitKey :: (key: s32) #foreign ray;

IsGamepadAvailable :: (gamepad: s32) -> bool #foreign ray;
GetGamepadName :: (gamepad: s32) -> string #foreign ray;
IsGamepadButtonPressed :: (gamepad: s32, button: s32) -> bool #foreign ray;
IsGamepadButtonDown :: (gamepad: s32, button: s32) -> bool #foreign ray;
IsGamepadButtonReleased :: (gamepad: s32, button: s32) -> bool #foreign ray;
IsGamepadButtonUp :: (gamepad: s32, button: s32) -> bool #foreign ray;
GetGamepadButtonPressed :: () -> int #foreign ray;
GetGamepadAxisCount :: (gamepad: s32) -> int #foreign ray;
GetGamepadAxisMovement :: (gamepad: s32, axis: s32) -> float #foreign ray;
SetGamepadMappings :: (mappings: *u8) -> int #foreign ray;
SetGamepadVibration :: (gamepad: s32, leftMotor: float, rightMotor: float, duration: float) #foreign ray;

IsMouseButtonPressed :: (button: s32) -> bool #foreign ray;
IsMouseButtonDown :: (button: s32) -> bool #foreign ray;
IsMouseButtonReleased :: (button: s32) -> bool #foreign ray;
IsMouseButtonUp :: (button: s32) -> bool #foreign ray;
GetMouseY :: () -> int #foreign ray;
GetMouseX :: () -> int #foreign ray;
GetMousePosition :: () -> Vector2 #foreign ray;
GetMouseDelta :: () -> Vector2 #foreign ray;
SetMousePosition :: (x: s32, y: s32) #foreign ray;
SetMouseOffset :: (offsetX: s32, offsetY: s32) #foreign ray;
SetMouseScale :: (scaleX: s32, scaleY: s32) #foreign ray;
GetMouseWheelMove :: () -> float #foreign ray;
GetMouseWheelMoveV :: () -> Vector2 #foreign ray;
SetMouseCursor :: (cursor: s32) #foreign ray;

//shapes
DrawPixel :: (posX: s32, posY: s32, color: u32) #foreign ray;
DrawLine :: (startPosX: s32, startPosY: s32, endPosX: s32, endPosY: s32, color: u32) #foreign ray;
