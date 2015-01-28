class PowerUp extends SpaceObjects {
  
  color colour;
  
  int rand;
  
  void display() {
    
  }
  
  void update() {
    
    if(count >= 90) {
      
      rand = (int)random(0, 8);
      
      count = 0;
      
    }
    
      
    if(rand < 8) {
      
      cent.add(move[rand]);
      
    }
    
    count++;
    
  }
  
}
