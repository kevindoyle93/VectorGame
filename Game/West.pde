class West extends Direction {
  
  West() {
    
    view = 2;
    
    cent = new PVector(centre.x, centre.y);
    
    background = loadImage("space2.jpg");
    background.resize(width, height);
    
    enemies = new ArrayList<Enemy>();
    
  }
    
  void display() {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).display();
      enemies.get(i).update();
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
  
  void addEnemy() {
    
    enemies.add(new Enemy(view));
    
  }
  
  
}
