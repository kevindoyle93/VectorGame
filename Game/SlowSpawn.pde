class SlowSpawn extends PowerUp {
  
  SlowSpawn(int view) {
    
    super();
    
    size = width / 70;
    
    colour = color(133, 183, 223);
    
  }
  
  void display() {
    
    for(float i = size; i > 1; i--) {
      
      stroke(colour);
      fill(colour);
      
      ellipse(cent.x, cent.y, i, i);
      
      colour = color(red(colour) - 5, green(colour) - 5, blue(colour) - 5);
      
    }
    
    colour = color(133, 183, 223);
    
  }
  
}
