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
  backgroundMusic.loop();
  gunSound = minim.loadFile("laser.mp3");
  boom = minim.loadFile("boom.mp3");
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  planets = new PVector[5];
  
  for(int i = 0; i < planets.length; i++) {
    
    planets[i] = new PVector(random(0, width), random(0, height));
    
  }
  
  hud = new HUD(centre.x, centre.y);
  
//  enemies = new ArrayList<Enemy>();
// 
//  for(int i = 0; i < 5; i++) {
//    
//    enemies.add(new Enemy());
//    
//  }
  
  bullets = new ArrayList<Bullet>();
  
  gun = new Gun();
  
  directions = new Direction[4];
  directions[0] = new North();
  directions[1] = new South();
  directions[2] = new West();
  directions[3] = new East();
  
  myFont = createFont("Rod", 20);
  textFont(myFont);
  
  spawnRate = 60;
  
}

HUD hud;

ArrayList<Bullet> bullets;


void draw() {
  
  background(0);
  
  //drawPlanets();
  
  spawnEnemies();
  
  p.update();
  
  
  for(int i = 0; i < bullets.size(); i++) {
    
    bullets.get(i).display();
    bullets.get(i).update();
  }
  
  hud.display();
  
}

PVector[] planets;

void drawPlanets() {
  
  int r, b, g;
  
  int size = height / 3;
  
  r = 255;
  g = 0;
  b = 0;
  
  stroke(r, b, g);
  
  for(int i = 0; i < planets.length; i++) {
    
    for(int j = 0; j < 10; j++) {
    
      ellipse(planets[i].x, planets[i].y, size, size);
      
      size--;
      
    }
    
  }
  
}

void spawnEnemies() {
  
  if((int)random(1, frameRate * 1000) < spawnRate) {
    
    directions[0].addEnemy();
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
    
