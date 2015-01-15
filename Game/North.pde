class North extends Direction {
  
//  PVector doorBL, doorBR, handleL, handleR;
//  
//  float doorH, doorW, handleSize;

  North() {
    
    cent = new PVector(centre.x, centre.y - 50);
    
    enemies = new ArrayList<Enemy>();
 
    for(int i = 0; i < 5; i++) {
      
      enemies.add(new Enemy());
      
    }
      
  }
    
  void display() {
    
    stroke(255);
    noFill();
    
    ellipse(cent.x, cent.y, 50, 50);
    
    for(int i = 0; i < enemies.size(); i++) {
    
      enemies.get(i).display();
      enemies.get(i).update();
    }
    
  }
  
}
