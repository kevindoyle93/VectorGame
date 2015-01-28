class Ammo extends PowerUp {
  
  float speed;
  
  int count;
  
  Ammo(int view) {
    
    super();
    
    size = width / 50;
    
    colour = color(141, 77, 137);
    
  }
  
  void display() {
    
    for(float i = size; i > 1; i--) {
      
      stroke(colour);
      fill(colour);
      
      ellipse(cent.x, cent.y, i, i);
      
      colour = color(red(colour) + 5, green(colour) + 5, blue(colour) + 5);
      
    }
    
    colour = color(141, 77, 137);
    
  }
  
}
