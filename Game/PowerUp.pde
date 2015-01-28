class PowerUp extends SpaceObjects {
  
  color colour;
  
  int rand;
  
  int count;
  
  float speed;
  
  PowerUp() {
    
    speed = 0.5f;
    
    move = new PVector[8];
    
    move[0] = new PVector(0, speed);
    move[1] = new PVector(0, -speed);
    move[2] = new PVector(-speed, 0);
    move[3] = new PVector(speed, 0);
    move[4] = new PVector(-(speed / 2.0f), -(speed / 2.0f));
    move[5] = new PVector(speed / 2.0f, -(speed / 2.0f));
    move[6] = new PVector(-(speed / 2.0f), speed / 2.0f);
    move[7] = new PVector(speed / 2.0f, speed / 2.0f);
    
    rand = 20;
    
    cent = new PVector(directions[view].cent.x, directions[view].cent.y);
    
    alive = true;
    
    count = 0;
    
  }
  
  void display() {
    
  }
  
  void update() {
    
    if(count >= 90) {
      
      rand = (int)random(0, 8);
      
      count = 0;
      
    }
    
      
    if(rand < 8) {
      
      cent.add(move[rand]);
      
    }
    
    count++;
    
  }
  
}
