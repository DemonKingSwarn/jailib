title :: "Square Shoot Frenzy";

window_factor :: 100;
width :: 16*window_factor;
height :: 9*window_factor;

CENTER :: Vector2.{width / 2, height / 2};

TOP_LEFT :: Vector2.{0, 0};
TOP_RIGHT :: Vector2.{1599, 0};
BOT_LEFT :: Vector2.{0, 899};
BOT_RIGHT :: Vector2.{1599, 899};

fps :: 60;

BLACK :: Color.{r = 0x00, g = 0x00, b = 0x00, a = 0xFF};
LIGHTRED :: Color.{r = 0xFF, g = 0x50, b = 0x50, a = 0xFF};
WHITE :: Color.{r = 0xFF, g = 0xFF, b = 0xFF, a = 0xFF};

DEBUG :: true;

Q_Key :: 81;
W_Key :: 87;
A_Key :: 65;
S_Key :: 83;
D_Key :: 68;

MOUSE_LEFT :: 0;
MOUSE_RIGHT :: 1;
