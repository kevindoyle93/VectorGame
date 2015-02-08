// PROXIMITY
// 
// written by Kevin Doyle (C13547287), 2015

class Player {
  
  int health, score, ammo;
  
  float speed;
  
  int count, coolDown;
  
  ControllStick leftStick;
  ControllStick rightStick;
  ControllButton button1;
  ControllButton button2;
  ControllButton button3;
  ControllButton button4;
  ControllButton start;
  
  PVector movement;
  
  Player() {
    
    ControllSlider sliderX = device.getSlider(0);
    ControllSlider sliderY = device.getSlider(1);
    
    leftStick = new ControllStick(sliderX, sliderY);
    
    sliderX = device.getSlider(2);
    sliderY = device.getSlider(3);
    
    rightStick = new ControllStick(sliderX, sliderY);
    
    button1 = device.getButton("Button 0");
    button2 = device.getButton("Button 1");
    start = device.getButton("Button 7");
        
    speed = 2.0f;
    
    movement = new PVector(0, 0);
    
    coolDown = 30;
    
    count = 0;
    
    score = 0;
    
    health = 100;
    
    ammo = 40;
        
  }
  
  void update() {
    
    switch(gameMode) {
      
      case 0: {
        
        if(start.pressed()) {
           
          gameMode = 1;
            
        }
        
        break;
        
      }
      case 1: {
        
        if(!setUp) {
          
          setupGame();
          
        }
        
        if(button1.pressed()) {
          
          setupGame();
          gameMode = 2;
          
        }
        
        if(button2.pressed()) {
          
          gameMode = 5;
          
        }
        
        break;
        
      }
      case 2: {
        
        if(p.health == 0) {
          
          gameMode = 3;
          
        }
          
        movement.set((float)leftStick.getY(), (float)leftStick.getX());
        
        directions[hud.view].cent.sub(movement);
        
        for(int i = 0; i < directions[hud.view].stars.size(); i++) {
          
          directions[hud.view].stars.get(i).cent.sub(movement);
          
        }
        
        for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
          
          if(directions[hud.view].spaceObjects.get(i) instanceof Enemy) {
            
            Enemy temp = (Enemy)directions[hud.view].spaceObjects.get(i);
            temp.cent.sub(movement);
          }
          else {
            
            directions[hud.view].spaceObjects.get(i).cent.sub(movement);
            
          }
          
        }
        
        for(int i = 0; i < bullets.size(); i++) {
          
          bullets.get(i).startPoint.sub(movement);
          bullets.get(i).endPoint.sub(movement);
          bullets.get(i).dest.sub(movement);
          
        }
        
        if(button1.pressed()) {
          
          if(coolDown > 10 && p.ammo > 0) {
          
            if(count % 2 == 0) {
            
              bullets.add(new Bullet(true));
            }
            else {
            
              bullets.add(new Bullet(false));
            }
            
            playerShoot.play(0);
            count++;
            p.ammo--;
            coolDown = 0;
            
          }
        }
        
        if(button2.pressed()) {
          
          for(int i = 0; i < directions[hud.view].spaceObjects.size(); i++) {
            
            if(directions[hud.view].spaceObjects.get(i) instanceof PowerUp) {
              
              PowerUp temp = (PowerUp)directions[hud.view].spaceObjects.get(i);
              
              if(temp.cent.x - centre.x < temp.size / 2 && centre.x - temp.cent.x < temp.size / 2 && temp.cent.y - centre.y < temp.size / 2 && centre.y - temp.cent.y < temp.size / 2) { 
                
                powerUp.play(0);
              
                if(directions[hud.view].spaceObjects.get(i) instanceof Ammo) {
                  
                  p.ammo = 40;
                  
                }
                else if(directions[hud.view].spaceObjects.get(i) instanceof Health) {
                  
                  if(p.health < 70) {
                  
                    p.health += 30;
                    
                  }
                  else {
                   
                    p.health = 100;
                    
                  }
                  
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
        
        if(rightStick.getX() > 0.5f) {
          
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
        
        if(rightStick.getX() < -0.5f) {
          
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
        
        if(rightStick.getY() > 0.5f) {
          
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
        
        if(rightStick.getY() < -0.5f) {
          
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
          
            if(leftStick.getX() > 0.5f && letter[textChoice] < 'Z') {
              
              letter[textChoice]++;
              
            }
            
            if(leftStick.getX() < -0.5f && letter[textChoice] > 'A') {
              
              letter[textChoice]--;
              
            }
            
            if(leftStick.getY() < -0.5f && textChoice > 0) {
              
              textChoice--;
              
            }
            
            if(leftStick.getY() > 0.5f && textChoice < 2) {
              
              textChoice++;
              
            }
            
            if(button1.pressed()){
              
              addToScores();
              
              gameMode = 4;
              
            }
            
            textWait = 0;
            
          }
          
        }
        else {
          
          if(start.pressed()) {
            
            gameMode = 1;
            
          }
          
          if(button2.pressed()) {
            
            gameMode = 4;
            
          }
          
        }
        
        break;
        
      } // end case 3:
      
      case 4: {
        
        if(start.pressed()){
          
          gameMode = 1;
          
        }
        
        break;
        
      }// end case 4:
      
      case 5: {
        
        if(button1.pressed()) {
          
          if(pageWait > 10) {
          
            page++;
            pageWait = 0;
            
          }
          
        }
        
        if(start.pressed()) {
          
          setUp = false;
          
          gameMode = 1;
          
        }
        
        pageWait++;
        
        break;
        
      }
      
    } // end switch()
  } // end update()
} // end Player
