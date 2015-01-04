PVector centre;

void setup()
{
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  hud = new HUD(centre.x, centre.y);
}

HUD hud;

void draw()
{
  background(0);
  
  hud.display();
}
