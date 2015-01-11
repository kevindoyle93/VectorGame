class Bullet {
  
  PVector startPoint;    // The start point will be passed by the Gun
  
  PVector endPoint;
  
  PVector movement;
  
  float l;
  
  float lDec;
  
  boolean left;
  
  float speed;
  
  boolean alive;
  
  Bullet(boolean left) {
    
    if(left) {
      
      startPoint = new PVector(hud.points[15].x, centre.y);
    
      movement = new PVector(1, 0);
      
    }
    else {
      
      startPoint = new PVector(hud.points[6].x, centre.y);
    
      movement = new PVector(-1, 0);
      
    }
    
    endPoint = new PVector(startPoint.x, startPoint.y);
    
    l = width / 20.0f;
    
    alive = true;
    
    this.left = left;
    
    speed = 10.0f;
    
    lDec = 0.1f;
    
  }
  
  void display() {
    
    stroke(255, 0, 0);
    fill(255, 0, 0);
    
    if(left) {
      
      endPoint.x = startPoint.x + l;
    }
    else {
      
      endPoint.x = startPoint.x - l;
    }
    
    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    
  }
  
  void update() {
    
    // Find the angle of the line from the gun's corner to the crosshair
    // Move along that line, decreasing the length of the bullet as it goes
    // Change alive to false if you it hits an enemy or dies
    
    startPoint.add(movement);
    
    l -= lDec;
    
    if(left) {
      
      if(endPoint.x > width / 2) {
        
        alive = !alive;
      }
      
      if(!alive) {
        
        bullets.remove(this);
      }
    }
    else {
      
      if(endPoint.x < width / 2) {
        
        alive = !alive;
      }
      
      if(!alive) {
        
        bullets.remove(this);
      }
    }
  }
  
}
