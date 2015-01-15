class East extends Direction {
  
  East() {
    
    cent = new PVector(centre.x + 50, centre.y);
    
  }
    
  void display() {
    
    stroke(255);
    noFill();
    
    ellipse(cent.x, cent.y, 50, 50);
    
  }
  
}
