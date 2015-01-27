class Direction {
  
  boolean display;
  
  PImage background;
  
  PVector cent;
  
  int view;
  
  ArrayList<Enemy> enemies;
  
  ArrayList<PowerUp> powerUps;
  
  ArrayList<BackgroundObjects> backgroundObjects;
  
  Direction(int view) {
    
    display = false;
    
    cent = new PVector(centre.x, centre.y);
    
    enemies = new ArrayList<Enemy>();
    
    powerUps = new ArrayList<PowerUp>();
    
    backgroundObjects = new ArrayList<BackgroundObjects>();
    
    makeBackground();
    
  }
  
  void display() {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).display();
      enemies.get(i).update();
    }
    
    for(int i = 0; i < powerUps.size(); i++) {
      
      powerUps.get(i).display();
      powerUps.get(i).update();
      
    }
    
    for(int i = 0; i < backgroundObjects.size(); i++) {
      
      backgroundObjects.get(i).display();
      backgroundObjects.get(i).update();
      
    }
    
  }
  
  void update() {
    
    sortEnemies();
    
  }
  
  void sortEnemies() {
    
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
    
  }
  
  void makeBackground() {
    
    for(int i = 0; i < 100; i++) {
      
      backgroundObjects.add(new Star(view));
      
    }
    
  }
  
  void addEnemy() {
    
    enemies.add(new Enemy(view));
    
  }
  
  void addPowerUp() {
    
    powerUps.add(new Ammo(view));
    
  }
  
}
