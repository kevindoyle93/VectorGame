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
  char north;
  char south;
  char east;
  char west;
  char button3;
  char button4;
  
  PVector gameUp, gameDown, gameLeft, gameRight;
  
  Player(char up, char down, char left, char right, char start, char button1, char button2, char north, char south, char east, char west, char button3, char button4) {
        
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    this.north = north;
    this.south = south;
    this.east = east;
    this.west = west;
    this.button3 = button3;
    this.button4 = button4;
    
  }
  
  Player(XML xml) {
    
    this(buttonNameToKey(xml, "up"), 
         buttonNameToKey(xml, "down"), 
         buttonNameToKey(xml, "left"), 
         buttonNameToKey(xml, "right"), 
         buttonNameToKey(xml, "start"), 
         buttonNameToKey(xml, "button1"), 
         buttonNameToKey(xml, "button2"), 
         buttonNameToKey(xml, "north"), 
         buttonNameToKey(xml, "south"), 
         buttonNameToKey(xml, "west"), 
         buttonNameToKey(xml, "east"), 
         buttonNameToKey(xml, "button3"), 
         buttonNameToKey(xml, "button4")
        );
        
        speed = 4.0f;
        
        gameUp = new PVector(0, -speed);
        gameDown = new PVector(0, speed);
        gameLeft = new PVector(-speed, 0);
        gameRight = new PVector(speed, 0);
        
        coolDown = 30;
        
        score = 0;
        
        health = 100;
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
      
      for(int i = 0; i < planets.length; i++) {
        
        planets[i].add(gameDown);
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
      
      for(int i = 0; i < planets.length; i++) {
        
        planets[i].add(gameUp);
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
      
      for(int i = 0; i < planets.length; i++) {
        
        planets[i].add(gameRight);
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
      
      for(int i = 0; i < planets.length; i++) {
        
        planets[i].add(gameLeft);
      }
    }
    
    if(checkKey(button1)) {
      
      if(coolDown > 10 && gun.ammo > 0) {
      
        if(count % 2 == 0) {
        
          bullets.add(new Bullet(true));
        }
        else {
        
          bullets.add(new Bullet(false));
        }
        
        count++;
        gun.ammo--;
        coolDown = 0;
        
      }
    }
      
    if(checkKey(button2)) {
      
      gun.ammo = 40;
      coolDown = -20;
      
    }
    
    coolDown++;
  }
}
