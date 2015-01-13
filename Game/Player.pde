class Player {
  
  String name;
  
  int score;
  
  int health;
  
  float speed;
  
  int coolDown;
  
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  
  PVector gameUp, gameDown, gameLeft, gameRight;
  
  Player(char up, char down, char left, char right, char start, char button1, char button2) {
        
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    
  }
  
  Player(XML xml) {
    
    this(buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
        
        speed = 2.0f;
        
        gameUp = new PVector(0, -speed);
        gameDown = new PVector(0, speed);
        gameLeft = new PVector(-speed, 0);
        gameRight = new PVector(speed, 0);
        
        coolDown = 30;
  }
  
  void update() {
    
    if(checkKey(up)) {
      
      for(int i = 0; i < enemies.size(); i++) {
      
        enemies.get(i).cent.add(gameDown);
      }
      
      for(int i = 0; i < bullets.size(); i++) {
        
        bullets.get(i).startPoint.add(gameDown);
        bullets.get(i).endPoint.add(gameDown);
        bullets.get(i).dest.add(gameDown);
      }
    }
    
    if(checkKey(down)) {
      
      for(int i = 0; i < enemies.size(); i++) {
      
        enemies.get(i).cent.add(gameUp);
      }
      
      for(int i = 0; i < bullets.size(); i++) {
        
        bullets.get(i).startPoint.add(gameUp);
        bullets.get(i).endPoint.add(gameUp);
      }
    }
    
    if(checkKey(left)) {
      
      for(int i = 0; i < enemies.size(); i++) {
      
        enemies.get(i).cent.add(gameRight);
      }
      
      for(int i = 0; i < bullets.size(); i++) {
        
        bullets.get(i).startPoint.add(gameRight);
        bullets.get(i).endPoint.add(gameRight);
        bullets.get(i).dest.add(gameRight);
      }
    }    
    
    if(checkKey(right)) {
      
      for(int i = 0; i < enemies.size(); i++) {
      
        enemies.get(i).cent.add(gameLeft);
      }
      
      for(int i = 0; i < bullets.size(); i++) {
        
        bullets.get(i).startPoint.add(gameLeft);
        bullets.get(i).endPoint.add(gameLeft);
        bullets.get(i).dest.add(gameLeft);
      }
    }
    
    if(checkKey(button1)) {
      
      if(coolDown > 10) {
      
        if(count % 2 == 0) {
        
          bullets.add(new Bullet(true));
        }
        else {
        
          bullets.add(new Bullet(false));
        }
        
        count++;
        coolDown = 0;
        
      }
      
    }
    
    coolDown++;
  }
}
