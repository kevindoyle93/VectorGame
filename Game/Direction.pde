class Direction {
  
  boolean display;
  
  PImage background;
  
  PVector cent;
  
  int view, enemyCount;
  
  ArrayList<SpaceObjects> spaceObjects;
  
  ArrayList<Star> stars;
  
  
  Direction(int view) {
    
    this.view = view;
    
    enemyCount = 0;
    
    display = false;
    
    cent = new PVector(centre.x, centre.y);
    
    spaceObjects = new ArrayList<SpaceObjects>();
    
    stars = new ArrayList<Star>();
    
    makeBackground();
    
  }
  
  void display() {
    
    for(int i = 0; i < stars.size(); i++) {
      
      stars.get(i).display();
      
    }

    for(int i = 0; i < spaceObjects.size(); i++) {
      
      spaceObjects.get(i).display();
      
    }
    
  }
  
  void update() {
    
    for(int i = 0; i < stars.size(); i++) {
      
      stars.get(i).update();
      
    }
    
    for(int i = 0; i < spaceObjects.size(); i++) {
      
      spaceObjects.get(i).update();
      
    }
    
    removeEnemies();
    
  }
  
  void makeBackground() {
    
    for(int i = 0; i < width / 20; i++) {
      
      stars.add(new Star());
      
    }
    
  }
  
  void addEnemy() {
    
    spaceObjects.add(new Enemy(view));
    spaceObjects.get(spaceObjects.size() - 1).alive = true;
    
    enemyCount++;
    
  }
  
  void removeEnemies() {
    
    for(int i = 0; i < spaceObjects.size(); i++) {
      
      if(spaceObjects.get(i).alive == false) {
        
        if(spaceObjects.get(i) instanceof Enemy) {
          
          enemyHit.play(0);
          
          p.score++;
          
        }
        
        
        spaceObjects.remove(spaceObjects.get(i));
        
        enemyCount--;
        
      }
      
    }
    
  }
  
  void addPowerUp(int type) {
    
    if(type == 0) {
      
      spaceObjects.add(new Ammo());
      
    }
    else if(type == 1) {
      
      spaceObjects.add(new Health());
      
    }
    else if(type == 2) {
      
      spaceObjects.add(new SlowSpeed());
      
    }
    else if(type == 3) {
      
      spaceObjects.add(new SlowSpawn());
      
    }
    
  }
  
}
