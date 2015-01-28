class Enemy extends SpaceObjects {
  
  float maxDist;
  
  float size, maxSize;
  
  float speed;
  
  int count;
  
  int rand;
  
  int progress;
  
  float loadTime;
  
  int coolDown;
  
  boolean loaded;
  
  boolean targeted;
  
  boolean lockedOn;
  
  boolean alive;
  
  Enemy(int view) {
    
    alive = true;
    
    maxDist = width / 200;
    
    maxSize = width / 20;
    
    cent = new PVector(directions[view].cent.x, directions[view].cent.y);
    
    size = 0;
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
    
    count = 30;
    
    coolDown = (int)random(0, 120);  // different enemies have different cool down periods
    
    loadTime = 240.0f;
    
    loaded = false;
    
    this.view = view;

  }
  
  void display() {
    
    fill(0);
    stroke(0);
    
    if(targeted) {
      stroke(236, 93, 78);
    }
    else {  
      stroke(255);
    }
    
    rect(cent.x - size / 2, cent.y - size / 2, size, size);
    
    ellipse(cent.x - size / 2, cent.y - size / 2, size / 4, size / 4);
    ellipse(cent.x + size / 2, cent.y - size / 2, size / 4, size / 4);
    ellipse(cent.x - size / 2, cent.y + size / 2, size / 4, size / 4);
    ellipse(cent.x + size / 2, cent.y + size / 2, size / 4, size / 4);
    
    line(cent.x - size / 2, cent.y, cent.x - size * 1.5f, cent.y);
    line(cent.x + size / 2, cent.y, cent.x + size * 1.5f, cent.y);
    
    noFill();
    arc(cent.x, cent.y, size * 3, size * 3, QUARTER_PI / 2 * 7, QUARTER_PI / 2 * 9);
    arc(cent.x, cent.y, size * 3, size * 3, -QUARTER_PI / 2, QUARTER_PI / 2);
    
  }
  
  void update() {
    
    checkTargeted();
    
    
    if(size > (maxSize - speed)) {
      
      //move away from player
      size -= speed;
      
      rand = (int)random(0, 20);
      
    }
    
    if(count >= 90) {
      
      rand = (int)random(0, 20);
      
      count = 0;
      
    }
    
      
    if(rand < 8) {
      
      if(allowMovement()) {
      
        cent.add(move[rand]);
        
      }
      else {
        
        rand = (int)random(0, 20);
        
      }
    }
    else if(rand > 7 && rand < 15) {
      
      size += speed / (frameRate / 2.0f);
    }
    
    count++;
    
    if(!loaded) {
      
      load();
      
    }
    else {
      
      shoot();
      
    }
    
    
  }
  
  void load() {
    
    progress++;
    
    if(progress > 250) {
        
      loaded = true;
      
      progress = 0;
      
    }
    
    if(view == hud.view) {
      
      stroke(130, 255, 80);
      fill(130, 255, 80);
      
      float x = (size / 2.0f / loadTime * progress);
      float y = (size / 2.0f / loadTime * progress);
      
      line(cent.x - size / 2, cent.y - size / 2, cent.x - size / 2 + x, cent.y - size / 2 + y);
      line(cent.x - size / 2, cent.y + size / 2, cent.x - size / 2 + x, cent.y + size / 2 - y);
      line(cent.x + size / 2, cent.y - size / 2, cent.x + size / 2 - x, cent.y - size / 2 + y);
      line(cent.x + size / 2, cent.y + size / 2, cent.x + size / 2 - x, cent.y + size / 2 - y);
      
      
      if(progress > loadTime) {
        
        fill(130, 255, 80);
        
        ellipse(cent.x, cent.y, progress % 240, progress % 240);
        
      }
      
    }
    
  }
  
  
  void shoot() {
    
    coolDown++;
    
    if(coolDown > 120) {
      
      enemyShoot.play(0);
      
      loaded = false;
      
      coolDown = 0;
      
      int chance = (int)(size / maxDist) * 3;
      
      int hit = (int)random(1, 101);
      
      if(hit < chance) {
        
        playerHit.play(0);
        
        p.health -= 10;
        
        background(0, 255, 0);
        
      }
      
    }
  }
  
  void checkTargeted() {
    
    if(centre.x > cent.x - size / 2 && centre.x < cent.x + size / 2 && centre.y > cent.y - size / 2 && centre.y < cent.y + size / 2) {
      
      targeted = true;
      
    }
    else {
      
      targeted = false;
      
    }
    
  }
  
  boolean allowMovement() {
    
    if(cent.x < (directions[view].cent.x - size * 10)) {
      
      return false;
      
    }
    
    if(cent.x > (directions[view].cent.x + size * 10)) {
      
      return false;
      
    }
    if(cent.y > (directions[view].cent.y + size * 6)) {
     
      return false;
    }
    if(cent.y < (directions[view].cent.y - size * 6)) {
      
      return false;
    }
    
    return true;
    
  }
  
}
