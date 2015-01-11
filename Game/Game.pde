PVector centre;

void setup() {
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  hud = new HUD(centre.x, centre.y);
  
  bullets = new ArrayList<Bullet>();
}

HUD hud;

ArrayList<Bullet> bullets;

void draw() {
  
  background(0);
  
  hud.display();
  
  for(int i = 0; i < bullets.size(); i++) {
    
    bullets.get(i).display();
    bullets.get(i).update();
  }
  
}


int count = 0;
void keyPressed() {
  
  if(key == 'e' || key == 'E') {
    
    if(count % 2 == 0) {
      
      bullets.add(new Bullet(true));
    }
    else {
      
      bullets.add(new Bullet(false));
    }
    count++;
  }
}
