class Direction {
  
  boolean display;
  
  PImage background;
  
  PVector cent;
  
  int view, enemyCount;
  
  ArrayList<SpaceObjects> spaceObjects;
  
  
  Direction(int view) {
    
    this.view = view;
    
    display = false;
    
    cent = new PVector(centre.x, centre.y);
    
    spaceObjects = new ArrayList<SpaceObjects>();
    
    enemyCount = 0;
    
    makeBackground();
    
  }
  
  void display() {

    for(int i = 0; i < spaceObjects.size(); i++) {
      
      spaceObjects.get(i).display();
      
    }
    
  }
  
  void update() {
    
    for(int i = 0; i < spaceObjects.size(); i++) {
      
      spaceObjects.get(i).update();
      
    }
    
    //sortEnemies();
    
    removeEnemies();
    
  }
  
  /* The enemies are sorted here so that the bigger (i.e. closer) enemies get displayed on top of smaller ones
  void sortEnemies() {
    
    ArrayList<Enemy> enemies = new ArrayList<Enemy>();
    
    for(int i = 0; i < spaceObjects.size(); i++) {
      
      if(spaceObjects.get(i) instanceof Enemy) {
        
        enemies.add((Enemy)spaceObjects.get(i));
        
        spaceObjects.remove(i);
        
      }
      
    }
    
    Enemy temp;
    
    for(int i = 0; i < enemies.size(); i++) {
      
      for(int j = 1; j < enemies.size(); j++) {
        
        if(enemies.get(j).size < enemies.get(j - 1).size) {
          temp = enemies.get(j);
          enemies.set(j, enemies.get(j - 1));
          enemies.set(j - 1, temp);
          
        }
      }
    }
    
    for(int i = 0; i < enemies.size(); i++) {
      
      spaceObjects.add(enemies.get(i));
      
    }
    
  }*/
  
  void makeBackground() {
    
    for(int i = 0; i < width / 2; i++) {
      
      spaceObjects.add(new Star(view));
      
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
          
          p.score++;
          
        }
        else {
          
          //powerup
          
        }
        
        spaceObjects.remove(spaceObjects.get(i));
        
      }
      
    }
    
  }
  
  void addPowerUp() {
    
    spaceObjects.add(new Ammo(view));
    
  }
  
}
