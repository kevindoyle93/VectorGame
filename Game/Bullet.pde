class Bullet {
  
  PVector startPoint;  // start of bullet
  
  PVector dest;        // destination of bullet
  
  PVector endPoint;    // end of bullet
  
  PVector movement;    // vector to be added to startPoint for movement
  
  float l;             // length of the bullet
  
  float lDec;          // decrements length to simulate 3D
  
  boolean left;        // whether the bullet is coming from the left or right
  
  float speed;
  
  boolean alive;
  
  boolean onTarget;    // whether or not a bullet, when shot, is on target to hit an enemy
  
  Bullet(boolean left) {
    
    speed = 20.0f;
    
    if(left) {
      
      startPoint = new PVector(hud.points[15].x, centre.y);
    
      movement = new PVector(speed, 0);
      
    }
    else {
      
      startPoint = new PVector(hud.points[6].x, centre.y);
    
      movement = new PVector(-speed, 0);
      
    }
    
    dest = new PVector(centre.x, centre.y);
    
    endPoint = startPoint.get();
    
    l = width / 30.0f;
    
    alive = true;
    
    this.left = left;
    
    lDec = speed / 10.0f;
    
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
  
  
  void checkCollision() {
    
    if(check1()) {
      
      bullets.remove(this);
      
    }
  }
  
  boolean check1() {
    
    boolean ret;
    
    for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
      
      if(directions[hud.view].spaceObjects.get(i) instanceof Enemy && onTarget) {
        
        Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
    
        if(left && temp.lockedOn) {
          
          if(temp.cent.x - endPoint.x < temp.size / 2 && (temp.cent.y - endPoint.y < temp.size / 2 && endPoint.y - temp.cent.y < temp.size / 2)) {
            
            ret = true;
              
            directions[hud.view].spaceObjects.get(i).alive = !ret;
            
            return ret;
            
          }
        }
      
        else if(!left && temp.lockedOn) {
          
          if(endPoint.x - temp.cent.x < temp.size / 2 && (temp.cent.y - endPoint.y < temp.size / 2 && endPoint.y - temp.cent.y < temp.size / 2)) {
            
            ret = true;
              
            directions[hud.view].spaceObjects.get(i).alive = !ret;
            
            return ret;
            
          }
        
        }
        
      }
    }
    
    ret = false;
    return ret;
    
  }
  
  
  void checkTarget() {
    
    for(int i = 0; i < directions.length; i++) {
    
      for(int j = 0; j < directions[i].spaceObjects.size(); j++) {
        
        if(directions[i].spaceObjects.get(j) instanceof Enemy) {
        
          Enemy temp = (Enemy)directions[i].spaceObjects.get(j);
          
          if(temp.targeted) {
            
            temp.lockedOn = true;
            
            onTarget = true;
            
            break;
            
          }
          
        }
        
      }
      
    }
    
  }
  
}
