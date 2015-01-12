PVector centre;

void setup() {
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  hud = new HUD(centre.x, centre.y);
  
  enemies = new ArrayList<Enemy>();
 
  for(int i = 0; i < 5; i++) {
    
    enemies.add(new Enemy());
    
  }
  
  bullets = new ArrayList<Bullet>();
  
}

HUD hud;

ArrayList<Bullet> bullets;

ArrayList<Enemy> enemies;

void draw() {
  
  background(0);
  
  for(int i = 0; i < enemies.size(); i++) {
    
    enemies.get(i).display();
    enemies.get(i).update();
  }
  
  for(int i = 0; i < bullets.size(); i++) {
    
    bullets.get(i).display();
    bullets.get(i).update();
  }
  
  hud.display();
  
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
  
  if(key == 'w' || key == 'W') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.y += 5;
    }
    
    for(int i = 0; i < bullets.size(); i++) {
      
      bullets.get(i).dest.y += 10;
    }
    
  }
  
  if(key == 's' || key == 'S') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.y -= 10;
    }
    
  }
  
  if(key == 'a' || key == 'A') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.x += 10;
    }
    
  }
  
  if(key == 'd' || key == 'D') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.x -= 10;
    }
    
  }
}
