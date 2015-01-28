// PROXIMITY
// 
// written by Kevin Doyle (C13547287), 2015

class SlowSpeed extends PowerUp {
  
  SlowSpeed() {
    
    super();
    
    size = width / 80;
    
    colour = color(255, 162, 59);
    
  }
  
  void display() {
    
    for(float i = size; i > 1; i--) {
      
      stroke(colour);
      fill(colour);
      
      ellipse(cent.x, cent.y, i, i);
      
      colour = color(red(colour) - 5, green(colour) - 5, blue(colour) - 5);
      
    }
    
    colour = color(255, 162, 59);
    
  }
  
}
