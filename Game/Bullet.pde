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
    
    for(int i = 0; i < directions.length; i++) {
    
      for(int j = 0; j < directions[i].spaceObjects.size(); j++) {
        
        if(directions[i].spaceObjects.get(j) instanceof Enemy) {
          
          Enemy temp = (Enemy)directions[i].spaceObjects.get(j);
      
          if(left) {
            
            if(endPoint.x > (temp.cent.x - (temp.size * 1.5))) {
              
              ret = check2(i, j, temp);
                
              temp.alive = !ret;
              
              return ret;
              
            }
          }
        
          else {
            
            if(endPoint.x < (temp.cent.x + (temp.size * 1.5))) {
              
              ret = check2(i, j, temp);
                
              temp.alive = !ret;
              
              return ret;
              
            }
          
          }
          
        }
      }
    }
    
    ret = false;
    return ret;
    
  }
  
  
  boolean check2(int i, int j, Enemy temp) {
    
    boolean ret;
    
    if(endPoint.y > (temp.cent.y - (temp.size / 2))) {
      
      ret = check3(i, j, temp);
      return ret;
      
    }
    
    ret = false;
    return ret;
    
  }
  
  boolean check3(int i, int j, Enemy temp) {
    
    boolean ret;
    
    if(endPoint.y < (temp.cent.y + (temp.size / 2))) {
      
      ret = true;
      return ret;
      
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
            
            break;
            
          }
          
        }
        
      }
      
    }
    
  }
  
}
