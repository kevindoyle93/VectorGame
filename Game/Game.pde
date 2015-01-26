import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// Audio
Minim minim;
AudioPlayer backgroundMusic;
AudioPlayer gunSound;
AudioPlayer boom;

PVector centre;
int gameMode;
boolean[] keys = new boolean[526];
Player p;
PFont myFont;
Gun gun;

int spawnRate;

Direction[] directions;

void setup() {
  
  setUpController();
  
  // Load music/sounds
  minim = new Minim(this);
  backgroundMusic = minim.loadFile("bgm.mp3");
  //backgroundMusic.loop();
  gunSound = minim.loadFile("laser.mp3");
  boom = minim.loadFile("boom.mp3");
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  planets = new PVector[5];
  
  for(int i = 0; i < planets.length; i++) {
    
    planets[i] = new PVector(random(0, width), random(0, height));
    
  }
  
  hud = new HUD(centre.x, centre.y);
  
  
  bullets = new ArrayList<Bullet>();
  
  gun = new Gun();
  
  directions = new Direction[4];
  directions[0] = new North();
  directions[1] = new South();
  directions[2] = new West();
  directions[3] = new East();
  
  directions[0].display = true;
  
  myFont = createFont("Rod", 20);
  textFont(myFont);
  
  spawnRate = 60;
  
  gameMode = 0;
  
}

HUD hud;

ArrayList<Bullet> bullets;

void draw() {
  
  background(0);
  
  switch(gameMode) {
    
    case 0: {
      
      mainMenu();
      p.update();
      break;
    }
    case 1: {
      
      startScreen();
      p.update();
      break;
    }
    case 2: {
      
      gamePlay();
      break;
    }
    default: {
      
      break;
    }
    
  }
  
}

void mainMenu() {
  
  fill(200);
  textSize(height * 0.15f);
  textAlign(CENTER, CENTER);
  text("PROXIMITY", width / 2, height * 0.15);
  
  stroke(255);
  noFill();
  for(float i = 0; i < 3; i++) {
    
    ellipse(width / 2, height / 2, width / 10 * (i + 0.5f), width / 10 * (i + 0.5f));
    
  }
  
  textSize(height * 0.05f);
  text("PRESS START", width / 2, height * 0.85);
  
}

void startScreen() {
  
  fill(200);
  
  String str1 = "PRESS BUTTON 1 TO BEGIN";
  String str2 = "PRESS BUTTON 2 FOR INSTRUCTIONS";
  
  textSize(width / str2.length());
  textAlign(CENTER, CENTER);
  text(str1, width / 2, height / 3);
  text(str2, width / 2, height / 3 * 2);
  
}

void gamePlay() {
  
  for(int i = 0; i < directions.length; i++) {
    
      if(directions[i].display) {
        
        background(directions[i].background);
        
      }
      
      directions[i].update();
      
    }

    spawnEnemies();
    
    p.update();
    
    
    for(int i = 0; i < bullets.size(); i++) {
      
      bullets.get(i).display();
      bullets.get(i).update();
    }
    
    hud.display();
}

void spawnEnemies() {
  
  if(spawnRate > frameRate * 1.5f) {
    
    int rand = (int)random(0, 4);
    
    directions[rand].addEnemy();
    spawnRate = 0;
  }
  
  spawnRate++;
  
}

int count = 99;

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
  
  XML playerXML = xml.getChild("player");
  
  p = new Player(playerXML);
  
}
    
