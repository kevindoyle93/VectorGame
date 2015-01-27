class Direction {
  
  boolean display;
  
  PImage background;
  
  PVector cent;
  
  int view, enemyCount;
  
  ArrayList<SpaceObjects> spaceObjects;
  
  
  Direction(int view) {
    
    display = false;
    
    cent = new PVector(centre.x, centre.y);
    
    spaceObjects = new ArrayList<SpaceObjects>();
    
    enemyCount = 0;
    
    makeBackground();
    
  }
  
  void display() {

    for(int i = 0; i < spaceObjects.size(); i++) {
      
      spaceObjects.get(i).display();
      spaceObjects.get(i).update();
      
    }
    
  }
  
  void update() {
    
    sortEnemies();
    
    removeEnemies();
    
  }
  
  void sortEnemies() {
    
    Enemy temp;
    
//    for(int i = 0; i < enemies.size(); i++) {
//      
//      for(int j = 1; j < enemies.size(); j++) {
//        
//        if(enemies.get(j).size < enemies.get(j - 1).size) {
//          
//          temp = enemies.get(j);
//          enemies.set(j, enemies.get(j - 1));
//          enemies.set(j - 1, temp);
//          
//        }
//      }
//    }
    
  }
  
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
        
        spaceObjects.remove(spaceObjects.get(i));
        
      }
      
    }
    
  }
  
  void addPowerUp() {
    
    spaceObjects.add(new Ammo(view));
    
  }
  
}
