PVector centre;
boolean[] keys = new boolean[526];
Player p;

void setup() {
  
  setUpController();
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  hud = new HUD(centre.x, centre.y);
  
  enemies = new ArrayList<Enemy>();
 
  for(int i = 0; i < 5; i++) {
    
    enemies.add(new Enemy());
    
  }
  
  bullets = new ArrayList<Bullet>();
  
}

HUD hud;

ArrayList<Bullet> bullets;

ArrayList<Enemy> enemies;

void draw() {
  
  background(0);
  
  p.update();
  
  for(int i = 0; i < enemies.size(); i++) {
    
    enemies.get(i).display();
    enemies.get(i).update();
  }
  
  for(int i = 0; i < bullets.size(); i++) {
    
    bullets.get(i).display();
    bullets.get(i).update();
  }
  
  hud.display();
  
}

int count = 0;
/*
void keyPressed() {
  
  if(key == 'e' || key == 'E') {
    
    if(count % 2 == 0) {
      
      bullets.add(new Bullet(true));
    }
    else {
      
      bullets.add(new Bullet(false));
    }
    count++;
  }
  
  if(key == 'w' || key == 'W') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.y += 5;
    }
    
    for(int i = 0; i < bullets.size(); i++) {
      
      bullets.get(i).dest.y += 10;
    }
    
  }
  
  if(key == 's' || key == 'S') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.y -= 10;
    }
    
  }
  
  if(key == 'a' || key == 'A') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.x += 10;
    }
    
  }
  
  if(key == 'd' || key == 'D') {
    
    for(int i = 0; i < enemies.size(); i++) {
      
      enemies.get(i).cent.x -= 10;
    }
    
  }
}
*/

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}


char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpController() {
  
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  println(children.length);
  
  for(int i = 0; i < 1; i++) {
    
    XML playerXML = children[i];
    p = new Player(playerXML);
    
    int x = (i + 1) * gap;
  }
  
}
    
