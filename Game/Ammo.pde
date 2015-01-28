class Ammo extends PowerUp {
  
  float speed;
  
  int count;
  
  Ammo(int view) {
    
    cent = new PVector(directions[view].cent.x, directions[view].cent.y);
    
    size = width / 50;
    
    colour = color(141, 77, 137);
    
    alive = true;
    
    speed = 0.5f;
    
    count = 0;
    
    rand = 20;
    
    move = new PVector[8];
    
    move[0] = new PVector(0, speed);
    move[1] = new PVector(0, -speed);
    move[2] = new PVector(-speed, 0);
    move[3] = new PVector(speed, 0);
    move[4] = new PVector(-(speed / 2.0f), -(speed / 2.0f));
    move[5] = new PVector(speed / 2.0f, -(speed / 2.0f));
    move[6] = new PVector(-(speed / 2.0f), speed / 2.0f);
    move[7] = new PVector(speed / 2.0f, speed / 2.0f);
    
  }
  
  void display() {
    
    for(float i = size; i > 1; i--) {
      
      stroke(colour);
      fill(colour);
      
      ellipse(cent.x, cent.y, i, i);
      
      colour = color(red(colour) + 5, green(colour) + 5, blue(colour) + 5);
      
    }
    
    colour = color(141, 77, 137);
    
  }
  
  void update() {
    
    
    if(count >= 90) {
      
      rand = (int)random(0, 11);
      
      count = 0;
      
    }
    
      
    if(rand < 8) {
      
      cent.add(move[rand]);
      
    }
    
    count++;
    
  }
  
}
