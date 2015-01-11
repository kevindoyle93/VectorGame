class Bullet {
  
  PVector startPoint;    // The start point will be passed by the Gun
  
  PVector endPoint;
  
  PVector movement;
  
  float l;
  
  float lDec;
  
  boolean left;
  
  float theta;
  
  float speed;
  
  boolean alive;
  
  Bullet(float gunX, float gunY, boolean left) {
    
    startPoint = new PVector(gunX, gunY);
    
    endPoint = new PVector(startPoint.x, startPoint.y);
    
    movement = new PVector(0, 0);
    
    l = width / 20;
    
    alive = true;
    
    this.left = left;
    
    speed = 10;
    
    theta = calculateTheta();
    
    calculateMovement();
    
  }
  
  void display() {
    
    stroke(255, 0, 0);
    fill(255, 0, 0);
    
    endPoint.x = startPoint.x + sin(theta) * l;
    endPoint.y = startPoint.y + -cos(theta) * l;
    
    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  }
  
  void update() {
    
    // Find the angle of the line from the gun's corner to the crosshair
    // Move along that line, decreasing the length of the bullet as it goes
    // Change alive to false if you it hits an enemy or dies
    
    startPoint.add(movement);
    
    l -= lDec;
    
    if(endPoint.x > width / 2) {
      
      alive = !alive;
    }
    
    if(!alive) {
      
      bullets.remove(this);
    }
  }
  
  float calculateTheta() {
    
    float aSquared;
    float sinRet;
    float a, b, c;
    float ret;
    
    b = width * 0.45;
    c = height * 0.3;
   
    aSquared = (sq(b)) + (sq(c)) - (2 * b * c * cos(PI / 2));
    
    a = sqrt(aSquared);
    
    calculateLDec(a);
    
    sinRet = (sin(PI / 2) * b) / a;
    
    ret = asin(sinRet);
    
    return ret;
  }
  
  void calculateMovement() {
    
    float angle = PI / 2 - theta;
    
    movement.x = (speed * sin(angle)) / sin(PI / 2);
    movement.y = -((movement.x * sin(angle)) / sin(PI / 2));
    
  }
  
  void calculateLDec(float a) {
    
    lDec = (a / 60) / (speed * 2);
    
  }
}
