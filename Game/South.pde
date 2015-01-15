class South extends Direction {
  
  South() {
    
    cent = new PVector(centre.x, centre.y + 50);
    
  }
    
  void display() {
    
    stroke(255);
    noFill();
    
    ellipse(cent.x, cent.y, 50, 50);
    
  }
  
}
