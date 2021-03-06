// PROXIMITY
// 
// written by Kevin Doyle (C13547287), 2015

class HUD {
  
  int numPoints = 16;
  
  PVector points[];
  
  PVector centre;
  
  int view;  // holds the direction player is facing
 
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
    
    view = 0;
  }
  
  void display() {
    
    stroke(0);
    fill(0);
    
    rect(0, 0, width, points[15].y);
    rect(0, points[14].y, width, height);
    rect(0, 0, points[14].x, height);
    rect(points[6].x, 0, width, height);
    
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
    
    stats();
    
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
    
    radius /= 4;
    
    ellipse(centre.x, centre.y, radius, radius);
    
  }
  
  void stats() {
    
    textSize((points[15].y - points[0].y) * 0.3);
    textAlign(LEFT, CENTER);
    fill(255);
    text("HEALTH:", points[0].x, (points[15].y - (points[0].y * 0.5)));
    
    float healthWidth = width * 0.15f * (p.health / 100.0f);
    float healthHeight = (points[15].y - points[0].y) / 3;
    
    if(p.health > 60) {
      
      fill(0, 255, 0);
    }
    else if(p.health > 30)  {
      
      fill(255, 255, 0);
    }
    else {
      
      fill(255, 0, 0);
    }
    
    rect(points[0].x + ((points[1].x - points[0].x) / 3), points[0].y + ((points[15].y - points[0].y) / 3), healthWidth, healthHeight);
    
    int ammoWidth = (int)(width * 0.2 / 40);
    float ammoHeight = healthHeight;
    float ammoGap = ammoWidth;
    
    fill(255);
    text("AMMO:", points[4].x, (points[15].y - (points[0].y * 0.5)));
    
    fill(255, 0, 0);
    for(int i = 0; i < p.ammo; i++) {
      
      rect(points[4].x + ((points[5].x - points[4].x) / 4) + (ammoGap * i), points[0].y + ((points[15].y - points[0].y) / 3), ammoWidth, ammoHeight);
    }
    
    fill(255);
    text("PROXIMITY:", points[13].x, (points[13].y - (points[0].y * 0.5)));
    proximity();
    
    
    fill(255);
    text("SCORE: " + p.score, points[9].x, (points[13].y - (points[0].y * 0.5)));
    
  }
  
  void proximity() {
    
    for(int i = 0; i < 4; i++) {
      
      color colour = color(200);
    
      if(directions[i].enemyCount > 0) {
        
        colour = color(0, 255, 0);
        
      }
    
      if(directions[i].enemyCount > 5) {
        
        colour = color(255, 255, 0);
        
      }
      
      if(directions[i].enemyCount > 10) {
        
        colour = color(255, 0, 0);
        
      }
      
      stroke(colour);
      fill(colour);
      
      float circX = points[13].x + ((points[12].x - points[13].x) / 2);
      float circY = points[13].y - ((points[13].y - points[14].y) / 2);
      float rad = (points[13].y - points[14].y) / 2;
      
      arc(circX, circY, rad, rad, (i * 2 + 5) * PI / 4, (i * 2 + 7) * PI / 4);
    }
    
  }
 
}
