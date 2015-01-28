class Star extends SpaceObjects {
  
  float theta, thetaInc;
  
  int points;
  
  Star() {
    
    float x = random(-(width * 1.2f), width * 1.2f);
    float y = random(-(height * 1.2f), height * 1.2f);
    
    cent = new PVector(x, y);
    
    points = 5;
    
    size = random(width * 0.003, width * 0.0013);
    
    alive = true;
    
  }
  
  Star(int view) {
    
    this();
    
    this.view = view;
    
  }
  
  void display() {
    
    pushMatrix();
    
    translate(cent.x, cent.y);
    rotate(theta);
    
    thetaInc = TWO_PI / points;
    float thetaTemp = theta;
    
    float x1, y1, x2, y2, x3, y3;
    
    for(int i = 0; i < points; i++) {
      
      x1 = sin(thetaTemp) * size;
      y1 = -cos(thetaTemp) * size;
      
      thetaTemp += thetaInc / 2;
      
      x2 = sin(thetaTemp) * size / 2;
      y2 = -cos(thetaTemp) * size / 2;
      
      thetaTemp += thetaInc / 2;
      
      x3 = sin(thetaTemp) * size;
      y3 = -cos(thetaTemp) * size;
      
      stroke(255);
      line(x1, y1, x2, y2);
      line(x2, y2, x3, y3);
      
    }
    
    popMatrix();
    
  }
  
  void update() {
    
    if(frameCount % 20 == 0) {
    
      theta += 0.1f;
      
    }
    
  }
  
}
