class Bullet {
  
  PVector origin;
  
  PVector startPoint;
  
  PVector dest;
  
  PVector endPoint;
  
  PVector movement;
  
  float l;
  
  PVector len;
  
  float lDec;
  
  float theta;
  
  boolean left;
  
  float speed;
  
  boolean alive;
  
  boolean onTarget;
  
  Bullet(boolean left) {
    
    speed = 20.0f;
    
    if(left) {
      
      origin = new PVector(hud.points[15].x, centre.y);
      
      startPoint = origin.get();
    
      movement = new PVector(speed, 0);
      
    }
    else {
      
      origin = new PVector(hud.points[6].x, centre.y);
      
      startPoint = origin.get();
    
      movement = new PVector(-speed, 0);
      
    }
    
    dest = new PVector(centre.x, centre.y);
    
    endPoint = startPoint.get();
    
    l = width / 30.0f;
    
    len = new PVector(l, 0);
    
    alive = true;
    
    this.left = left;
    
    lDec = speed / 10.0f;
    
    theta = PI;
    
    checkTarget();
    
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
    
    calculateMovement();
    
    startPoint.add(movement);
    
    if(l > lDec) {
      
      l -= lDec;
      
    }
    
    if(left) {
      
      if(endPoint.x > dest.x) {
        
        alive = !alive;
      }
      
      if(!alive) {
        
        bullets.remove(this);
      }
    }
    else {
      
      if(endPoint.x < dest.x) {
        
        alive = !alive;
      }
      
      if(!alive) {
        
        bullets.remove(this);
      }
    }
    
    checkCollision();
    
  }
  
  
  void calculateMovement() {
    
    
  }
  
  
  void checkCollision() {
    
    if(check1()) {
      
      bullets.remove(this);
      
    }
  }
  
  boolean check1() {
    
    boolean ret;
    
    for(int i = 0; i < directions[0].enemies.size(); i++) {
      
      if(directions[0].enemies.get(i).lockedOn) {
    
        if(left) {
          
          if(endPoint.x > (directions[0].enemies.get(i).cent.x - (directions[0].enemies.get(i).size * 1.5))) {
            
            ret = check2(i);
              
            directions[0].enemies.get(i).alive = !ret;
            
            return ret;
            
          }
        }
      
        else {
          
          if(endPoint.x < (directions[0].enemies.get(i).cent.x + (directions[0].enemies.get(i).size * 1.5))) {
            
            ret = check2(i);
              
            directions[0].enemies.get(i).alive = !ret;
            
            return ret;
            
          }
        
        }
        
      }
    }
    
    ret = false;
    return ret;
    
  }
  
  
  boolean check2(int i) {
    
    boolean ret;
    
    if(endPoint.y > (directions[0].enemies.get(i).cent.y - (directions[0].enemies.get(i).size / 2))) {
      
      ret = check3(i);
      return ret;
      
    }
    
    ret = false;
    return ret;
    
  }
  
  boolean check3(int i) {
    
    boolean ret;
    
    if(endPoint.y < (directions[0].enemies.get(i).cent.y + (directions[0].enemies.get(i).size / 2))) {
      
      ret = true;
      return ret;
      
    }
    
    ret = false;
    return ret;
    
  }
  
  void checkTarget() {
    
    for(int i = 0; i < directions[0].enemies.size(); i++) {
      
      if(directions[0].enemies.get(i).targeted) {
        
        directions[0].enemies.get(i).lockedOn = true;
        
        break;
        
      }
      
    }
    
  }
  
}
