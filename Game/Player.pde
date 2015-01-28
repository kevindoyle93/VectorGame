class Player {
  
  int health, score, ammo;
  
  float speed;
  
  int count, coolDown;
  
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
        
        count = 0;
        
        score = 0;
        
        health = 100;
        
        ammo = 40;
        
  }
  
  void update() {
    
    switch(gameMode) {
      
      case 0: {
        
        if(checkKey(start)) {
           
          gameMode = 1;
            
        }
        
        break;
        
      }
      case 1: {
        
        setupGame();
        
        if(checkKey(button1)) {
          
          gameMode = 2;
          
        }
        
        if(checkKey(button2)) {
          
          gameMode = 5;
          
        }
        
        break;
        
      }
      case 2: {
        
        if(p.health == 0) {
          
          gameMode = 3;
          
        }
    
        if(checkKey(up)) {
            
          directions[hud.view].cent.add(gameUp);
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof Enemy) {
              
              Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
              temp.cent.add(gameUp);
            }
            else {
              
              directions[hud.view].spaceObjects.get(i).cent.add(gameUp);
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameUp);
            bullets.get(i).endPoint.add(gameUp);
            bullets.get(i).dest.add(gameUp);
            
          }
          
        }
        
        if(checkKey(down)) {
          
          directions[hud.view].cent.add(gameDown);
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof Enemy) {
              
              Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
              temp.cent.add(gameDown);
            }
            else {
              
              directions[hud.view].spaceObjects.get(i).cent.add(gameDown);
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameDown);
            bullets.get(i).endPoint.add(gameDown);
            bullets.get(i).dest.add(gameDown);
            
          }
          
        }
        
        if(checkKey(left)) {
          
          directions[hud.view].cent.add(gameLeft);
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof Enemy) {
              
              Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
              temp.cent.add(gameLeft);
            }
            else {
              
              directions[hud.view].spaceObjects.get(i).cent.add(gameLeft);
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameLeft);
            bullets.get(i).endPoint.add(gameLeft);
            bullets.get(i).dest.add(gameLeft);
            
          }
          
        }    
        
        if(checkKey(right)) {
          
          directions[hud.view].cent.add(gameRight);
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof Enemy) {
              
              Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
              temp.cent.add(gameRight);
            }
            else {
              
              directions[hud.view].spaceObjects.get(i).cent.add(gameRight);
              
            }
            
          }
          
          for(int i = 0; i < bullets.size(); i++) {
            
            bullets.get(i).startPoint.add(gameRight);
            bullets.get(i).endPoint.add(gameRight);
            bullets.get(i).dest.add(gameRight);
            
          }
          
        }
        
        if(checkKey(button1)) {
          
          if(coolDown > 10 && p.ammo > 0) {
          
            if(count % 2 == 0) {
            
              bullets.add(new Bullet(true));
            }
            else {
            
              bullets.add(new Bullet(false));
            }
            
            gunSound.play(0);
            count++;
            p.ammo--;
            coolDown = 0;
            
          }
        }
        
        if(checkKey(button2)) {
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof PowerUp) {
              
              PowerUp temp = (PowerUp)directions[hud.view].spaceObjects.get(i);
              
              if(temp.cent.x - centre.x < temp.size / 2 && centre.x - temp.cent.x < temp.size / 2 && temp.cent.y - centre.y < temp.size / 2 && centre.y - temp.cent.y < temp.size / 2) { 
              
                if(directions[hud.view].spaceObjects.get(i) instanceof Ammo) {
                  
                  p.ammo = 40;
                  
                }
                else if(directions[hud.view].spaceObjects.get(i) instanceof SlowSpeed) {
                  
                  for(int j = 0; j < directions.length; j++) {
                    
                    for(int k = 0; k < directions[j].spaceObjects.size(); k++) {
                      
                      if(directions[j].spaceObjects.get(k) instanceof Enemy) {
                        
                        directions[j].spaceObjects.get(k).speed = 0.5f;
                        
                      }
                      
                    }
                    
                  }
                  
                }
                else if(directions[hud.view].spaceObjects.get(i) instanceof SlowSpawn) {
                  
                  enemySpawnRate = 150;
                  
                }
                
                directions[hud.view].spaceObjects.remove(i);
                
              }
              
            }
            
          }
          
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
        
        break;
        
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
        
        break;
        
      }// end case 4:
      
      case 5: {
        
        if(checkKey(button1)) {
          
          if(pageWait > 10) {
          
            page++;
            pageWait = 0;
            
          }
          
        }
        
        if(checkKey(start)) {
          
          gameMode = 1;
          
        }
        
        pageWait++;
        
        break;
        
      }
      
    } // end switch()
  } // end update()
} // end Player
