class Bullet {
  
  PVector startPoint;    // The start point will be passed by the Gun
  
  float l;
  
  boolean left;
  
  boolean alive;
  
  Bullet(float gunX, float gunY, boolean left) {
    
    startPoint = new PVector(gunX, gunY);
    
    l = height / 50;
    
    alive = true;
    
    this.left = left;
    
  }
  
  void display() {
    
    stroke(255, 0, 0);
    fill(255, 0, 0);
    
    float x = 0, y = 0;
    
    line(startPoint.x, startPoint.y, x, y);
  }
  
  void update() {
    
    // Find the angle of the line from the gun's corner to the crosshair
    // Move along that line, decreasing the length of the bullet as it goes
    // Change alive to false if you it hits an enemy or dies
  }
  
}
