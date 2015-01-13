class Enemy {
  
  PVector cent;
  
  PVector[] move;
  
  PVector up, down, left, right, lUp, rUp, lDown, rDown;
  
  float maxDist, minDist;
  
  float size;
  
  float speed;
  
  int count;
  
  int rand;
  
  int progress;
  
  int coolDown;
  
  boolean loaded;
  
  boolean targeted;
  
  Enemy() {
    
    maxDist = width / 200;
    
    minDist = width / 25;
    
    cent = new PVector(random(width * 0.2, width * 0.8), random(height * 0.3, height * 0.7));
    
    size = maxDist;
    
    speed = 0.25f;
    
    move = new PVector[8];
    
    move[0] = new PVector(0, speed);
    move[1] = new PVector(0, -speed);
    move[2] = new PVector(-speed, 0);
    move[3] = new PVector(speed, 0);
    move[4] = new PVector(-(speed / 2.0f), -(speed / 2.0f));
    move[5] = new PVector(speed / 2.0f, -(speed / 2.0f));
    move[6] = new PVector(-(speed / 2.0f), speed / 2.0f);
    move[7] = new PVector(speed / 2.0f, speed / 2.0f);
    
    count = 30; //half of 60fps
    
    loaded = false;

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
    
    //size = minDist;
    
    if(size > (minDist - speed)) {
      
      //move away from player
      size -= speed;
      
      rand = (int)random(0, 20);
      
    }
    
    if(count >= 30) {
      
      rand = (int)random(0, 20);
      
      count = 0;
      
    }
    
      
    if(rand < 8) {
      
      cent.add(move[rand]);
    }
    else if(rand > 7 && rand < 15) {
      
      size += speed / 10;
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
    
    stroke(130, 255, 80);
    
    float x = (size / 2.0f / 240.0f * progress);
    float y = (size / 2.0f / 240.0f * progress);
    
    line(cent.x - size / 2, cent.y - size / 2, cent.x - size / 2 + x, cent.y - size / 2 + y);
    line(cent.x - size / 2, cent.y + size / 2, cent.x - size / 2 + x, cent.y + size / 2 - y);
    line(cent.x + size / 2, cent.y - size / 2, cent.x + size / 2 - x, cent.y - size / 2 + y);
    line(cent.x + size / 2, cent.y + size / 2, cent.x + size / 2 - x, cent.y + size / 2 - y);
    
    if(progress > 240) {
      
      fill(130, 255, 80);
      
      ellipse(cent.x, cent.y, progress % 240, progress % 240);
      
    }
    
  }
  
  void shoot() {
    
    coolDown++;
    
    if(coolDown > 120) {
      
      loaded = false;
      
      coolDown = 0;
      
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
  
}
