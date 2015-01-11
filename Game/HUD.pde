class HUD {
  
  int numPoints = 16;
  
  PVector points[];
  
  PVector centre;
 
  HUD(float centX, float centY) {
    
    centre = new PVector(centX, centY);
    
    points = new PVector[numPoints];
    
    points[0] = new PVector(width * 0.15f, height * 0.1f);
    points[1] = new PVector(width * 0.4f, height * 0.1f);
    
    points[2] = new PVector(width * 0.45f, height * 0.2f);
    points[3] = new PVector(width * 0.55f, height * 0.2f);
    
    points[4] = new PVector(width * 0.6f, height * 0.1f);
    points[5] = new PVector(width * 0.85f, height * 0.1f);
    
    points[6] = new PVector(width * 0.95f, height * 0.2f);
    points[7] = new PVector(width * 0.95f, height * 0.8f);
    
    points[8] = new PVector(width * 0.85f, height * 0.9f);
    points[9] = new PVector(width * 0.6f, height * 0.9f);
    
    points[10] = new PVector(width * 0.55f, height * 0.8f);
    points[11] = new PVector(width * 0.45f, height * 0.8f);
    
    points[12] = new PVector(width * 0.4f, height * 0.9f);
    points[13] = new PVector(width * 0.15f, height * 0.9f);
    
    points[14] = new PVector(width * 0.05f, height * 0.8f);
    points[15] = new PVector(width * 0.05f, height * 0.2f);
  }
  
  void display() {
    
    stroke(255);
    
    for(int i = 0; i < points.length; i++) {
      
      line(points[i].x, points[i].y, points[(i + 1) % numPoints].x, points[(i + 1) % numPoints].y);
    }
    
    stroke(130, 255, 80);
    
    line(points[15].x, points[15].y, points[2].x, points[2].y);
    line(points[3].x, points[3].y, points[6].x, points[6].y);
    line(points[10].x, points[10].y, points[7].x, points[7].y);
    line(points[14].x, points[14].y, points[11].x, points[11].y);
    
    crosshair();
  }
  
  void crosshair() {
    
    float radius = width / 100;
    float theta = TWO_PI / 8;
    float points = 4;
    float thetaSpace = TWO_PI / points;

    
    stroke(130, 255, 80);
    
    for(int i = 0; i < points; i++) {
      
      float x = centre.x + sin(theta) * radius;
      float y = centre.y + cos(theta) * radius;
      
      line(centre.x, centre.y, x, y);
      
      theta += thetaSpace;
    }
    
    stroke(0);
    fill(0);
    
    radius /= 2;
    
    ellipse(centre.x, centre.y, radius, radius);
    
  }
 
}
