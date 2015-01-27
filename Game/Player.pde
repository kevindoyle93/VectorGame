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
        
        speed = 2.0f;
        
        gameUp = new PVector(0, -speed);
        gameDown = new PVector(0, speed);
        gameLeft = new PVector(-speed, 0);
        gameRight = new PVector(speed, 0);
        
        coolDown = 30;
        
        score = 10;
        
        health = 10;
  }
  
  void update() {
    
    switch(gameMode) {
      
      case 0: {
        
        if(checkKey(start)) {
            
          coolDown = 0;
          gameMode = 1;
            
        }
        
        break;
        
      }
      case 1: {
        
        if(checkKey(button1)) {
          
          gameMode = 2;
          
        }
        
        break;
        
      }
      case 2: {
        
        if(p.health == 0) {
          
          gameMode = 3;
          
        }
    
        if(checkKey(up)) {
          
          for(int i = 0; i < directions.length; i++) {
            
            if(directions[i].display) {
            
              directions[i].cent.add(gameDown);
              
              for(int j = 0; j < directions[i].enemies.size(); j++) {
              
                directions[i].enemies.get(j).cent.add(gameDown);
              }
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameDown);
            bullets.get(i).endPoint.add(gameDown);
            bullets.get(i).dest.add(gameDown);
          }
        }
        
        if(checkKey(down)) {
          
          for(int i = 0; i < directions.length; i++) {
            
            if(directions[i].display) {
            
              directions[i].cent.add(gameUp);
              
              for(int j = 0; j < directions[i].enemies.size(); j++) {
              
                directions[i].enemies.get(j).cent.add(gameUp);
              }
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameUp);
            bullets.get(i).endPoint.add(gameUp);
          }
          
        }
        
        if(checkKey(left)) {
          
          for(int i = 0; i < directions.length; i++) {
            
            if(directions[i].display) {
            
              directions[i].cent.add(gameRight);
              
              for(int j = 0; j < directions[i].enemies.size(); j++) {
              
                directions[i].enemies.get(j).cent.add(gameRight);
              }
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameRight);
            bullets.get(i).endPoint.add(gameRight);
            bullets.get(i).dest.add(gameRight);
          }
          
        }    
        
        if(checkKey(right)) {
          
          for(int i = 0; i < directions.length; i++) {
            
            if(directions[i].display) {
            
              directions[i].cent.add(gameLeft);
              
              for(int j = 0; j < directions[i].enemies.size(); j++) {
              
                directions[i].enemies.get(j).cent.add(gameLeft);
              }
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameLeft);
            bullets.get(i).endPoint.add(gameLeft);
            bullets.get(i).dest.add(gameLeft);
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
            
            gunSound.play(0);
            count++;
            gun.ammo--;
            coolDown = 0;
            
          }
        }
          
        if(checkKey(button2)) {
          
          gun.ammo = 40;
          coolDown = -20;
          
        }
        
        if(checkKey(north)) {
          
          hud.view = 0;
          
          for(int i = 0; i < directions.length; i++) {
            
            if(i == hud.view) {
              
              directions[i].display = true;
              
            }
            
            else {
              
              directions[i].display = false;
              directions[i].cent.x = centre.x;
              directions[i].cent.y = centre.y;
              
            }
            
          }
          
        }
        
        if(checkKey(south)) {
          
          hud.view = 1;
          
          for(int i = 0; i < directions.length; i++) {
            
            if(i == hud.view) {
              
              directions[i].display = true;
              
            }
            
            else {
              
              directions[i].display = false;
              directions[i].cent.x = centre.x;
              directions[i].cent.y = centre.y;
              
            }
            
          }
          
        }
        
        if(checkKey(west)) {
          
          hud.view = 2;
          
          for(int i = 0; i < directions.length; i++) {
            
            if(i == hud.view) {
              
              directions[i].display = true;
              
            }
            
            else {
              
              directions[i].display = false;
              directions[i].cent.x = centre.x;
              directions[i].cent.y = centre.y;
              
            }
            
          }
          
        }
        
        if(checkKey(east)) {
          
          hud.view = 3;
          
          for(int i = 0; i < directions.length; i++) {
            
            if(i == hud.view) {
              
              directions[i].display = true;
              
            }
            
            else {
              
              directions[i].display = false;
              directions[i].cent.x = centre.x;
              directions[i].cent.y = centre.y;
              
            }
            
          }
          
        }
        
        coolDown++;
      } // end case 2
      case 3: {
        
        if(onTable) {
          
          if(textWait > 10) {
          
            if(checkKey(up) && letter[textChoice] < 'Z') {
              
              letter[textChoice]++;
              
            }
            
            if(checkKey(down) && letter[textChoice] > 'A') {
              
              letter[textChoice]--;
              
            }
            
            if(checkKey(left) && textChoice > 0) {
              
              textChoice--;
              
            }
            
            if(checkKey(right) && textChoice < 2) {
              
              textChoice++;
              
            }
            
            if(checkKey(button1)){
              
              addToScores();
              
              gameMode = 4;
              
            }
            
            textWait = 0;
            
          }
          
        }
        else {
          
          if(checkKey(start)) {
            
            gameMode = 1;
            
          }
          
          if(checkKey(button2)) {
            
            gameMode = 4;
            
          }
          
        }
        
        break;
        
      } // end case 3:
      
      case 4: {
        
        if(checkKey(start)){
          
          gameMode = 1;
          
        }
        
      }
      
    } // end switch()
  } // end update()
} // end Player
