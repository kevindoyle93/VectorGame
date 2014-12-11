float centX, centY;

void setup()
{
  size(900, 500);
  
  centX = width / 2;
  centY = height / 2;
  
  hud = new HUD(centX, centY);
}

HUD hud;

void draw()
{
  background(0);
  
  hud.display();
}
