import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// Audio
Minim minim;
AudioPlayer backgroundMusic;
AudioPlayer playerShoot;
AudioPlayer playerHit;
AudioPlayer enemyShoot;
AudioPlayer enemyHit;
AudioPlayer powerUp;

PVector centre;
int gameMode;
boolean[] keys = new boolean[526];
Player p;
PFont myFont;


Direction[] directions;

HUD hud;

ArrayList<Bullet> bullets;


void setup() {
  
  setUpController();
  
  readHighScores();
  
  // Load music/sounds
  minim = new Minim(this);
  
//  backgroundMusic = minim.loadFile("bgm.mp3");
//  backgroundMusic.loop();
  
  
  playerShoot = minim.loadFile("/sounds/PlayerShoot.wav");
  playerHit = minim.loadFile("/sounds/PlayerHit.wav");
  enemyShoot = minim.loadFile("/sounds/EnemyShoot.wav");
  enemyHit = minim.loadFile("/sounds/EnemyHit.wav");
  powerUp = minim.loadFile("/sounds/Powerup.wav");
  
  size(900, 500);
  
  centre = new PVector(width / 2, height / 2);
  
  hud = new HUD(centre.x, centre.y);
  
  directions = new Direction[4];
  
  myFont = createFont("Rod", 20);
  textFont(myFont);
  
  gameMode = 0;
  
}

void draw() {
  
  background(0);
  
  switch(gameMode) {
    
    case 0: {
      
      mainMenu();
      break;
    }
    case 1: {
      
      startScreen();
      break;
    }
    case 2: {
      
      gamePlay();
      break;
      
    }
    case 3: {
      
      endScreen();
      break;
      
    }
    case 4: {
      
      displayHighScores();
      break;
      
    }
    case 5: {
      
      instructions();
      break;
      
    }
    default: {
      
      break;
      
    }
    
  }
  
  p.update();
  
}

void setupGame() {
  
  p.score = 0;
  p.health = 100;
  p.ammo = 40;
  p.coolDown = 0;
  
  enemySpawnRate = 120;
  enemySpawn = 60;
  
  bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < 4; i++) {
    
    directions[i] = new Direction(i);
    
  }
  
  directions[0].display = true;
  
  letter = new char[3];
  
  for(int i = 0; i < letter.length; i++) {
    
    letter[i] = 'A';
    
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

int page, pageWait;

void instructions() {
  
  hud.display();
  
  fill(200);
  textSize(height * 0.03f);
  
  switch(page) {
    
    case 0: {
   
      textAlign(CENTER, CENTER);
      
      // Crosshair info
      text("THE CROSSHAIRS ARE WHERE YOU ARE AIMING", centre.x, height * 0.4);
      text("USE THE LEFT STICK TO AIM, AND BUTTON 1 TO SHOOT", centre.x, height * 0.45);
      text("ENEMIES TURN RED WHEN YOU HAVE THEM IN YOUR SIGHTS", centre.x, height * 0.55);
      
      text("PRESS BUTTON 1", centre.x, height * 0.7);
      
      break;
      
    }
    
    case 1: {
   
      textAlign(CENTER, CENTER);
      
      text("TARGET POWERUPS JUST LIKE ENEMIES, BUT PRESS BUTTON 2 TO COLLECT THEM", centre.x, height * 0.45);
      text("PURPLE: INCREASE AMMO", centre.x, height * 0.55);
      text("BLUE: SLOW ENEMY SPAWN RATE", centre.x, height * 0.6);
      text("GOLD: SLOW ENEMY SPEED", centre.x, height * 0.65);
      
      text("PRESS BUTTON 1", centre.x, height * 0.7);
      
      break;
      
    }
    
    case 2: {
      
      textAlign(CENTER, CENTER);
      
      text("ENEMIES CAN COME FROM ALL DIRECTIONS", centre.x, height * 0.45);
      text("USE THE RIGHT STICK TO LOOK NORTH, SOUTH, EAST, OR WEST", centre.x, height * 0.5);
      
      text("PRESS BUTTON 1", centre.x, height * 0.7);
      
      break;
      
      
    }
    
    case 3: {
  
      // Proximity info
      textAlign(LEFT, CENTER);
      
      directions[0].enemyCount = 0;
      directions[1].enemyCount = 6;
      directions[2].enemyCount = 11;
      directions[3].enemyCount = 1;
      
      text("  THE PROXIMITY WARNING SYSTEM ALERTS YOU TO DANGER TO THE NORTH, SOUTH, EAST, AND WEST", hud.points[14].x, height * 0.7);
      text("  GREY - SAFE, GREEN - >0 ENEMIES, YELLOW - >5 ENEMIES, RED - >10 ENEMIES", hud.points[14].x, height * 0.75);
      
      textAlign(CENTER, CENTER);
      text("PRESS BUTTON 1", centre.x, height * 0.6);
      
      break;
      
    }
    
    default : {
      
      textAlign(CENTER, CENTER);
      
      text("PRESS START TO RETURN", centre.x, height * 0.45);
      
      break;
      
    }
    
  }
  
}

void gamePlay() {
  
  directions[hud.view].display();
  
  for(int i = 0; i < directions.length; i++) {
      
      directions[i].update();
      
    }
    
  for(int i = 0; i < bullets.size(); i++) {
    
    bullets.get(i).display();
    bullets.get(i).update();
  }
  
  hud.display();
  
  p.update();
  
  spawnEnemies();
  spawnPowerUps();
  
  for(int i = 0; i < directions.length; i++) {
    
    for(int j = 0; j < directions[i].spaceObjects.size(); j++) {
      
      if(directions[i].spaceObjects.get(j) instanceof Enemy) {
      
        directions[i].spaceObjects.get(j).speed += 0.005f;
        
      }
      
    }
    
  }
  
  if(enemySpawnRate > frameRate) {
    
    enemySpawnRate -= 0.01f;
    
  }
  
}

boolean onTable;

void endScreen() {
  
  fill(200);
  textSize(height * 0.15f);
  textAlign(CENTER, CENTER);
  text("YOU LOSE", width / 2, height * 0.15);
  
  textSize(height * 0.05f);
  text("YOUR SCORE WAS", width / 2, height * 0.4);
  text(p.score, width / 2, height * 0.5);
  
  if(p.score > highScores.get(4).score) {
    
    onTable = true;
    
    text("ENTER YOUR NAME BELOW AND PRESS BUTTON 1", width / 2, height * 0.7);
    
    readName();
    
  }
  else {
  
    text("PRESS START TO RETURN TO THE MAIN MENU", width / 2, height * 0.7);
    text("PRESS BUTTON 2 TO VIEW THE HIGH SCORES", width / 2, height * 0.8);
    
  }
  
}

void displayHighScores() {
  
  fill(200);
  textSize(height * 0.15f);
  textAlign(CENTER, CENTER);
  text("HIGH SCORES", width / 2, height * 0.15);
  
  textSize(height * 0.05f);
  
  for(int i = 0; i < highScores.size(); i++) {
    
    text((i + 1) + ".   " + highScores.get(i).name + "   " + highScores.get(i).score, width / 2, height / 10 * (3.5f + i));
   
  }
  
  text("PRESS START TO RETURN TO THE MAIN MENU", width / 2, height * 0.9f);
 
} 


float enemySpawnRate, enemySpawn;

void spawnEnemies() {
  
  if(enemySpawnRate < enemySpawn) {
    
    int rand = (int)random(0, 4);
    
    directions[rand].addEnemy();
    enemySpawn = 0;
  }
  
  enemySpawn++;
  
}

void spawnPowerUps() {
  
  if(frameCount % 60 == 0) {
  
    int rand = (int)random(0, 100);
    
    int view = (int)random(0, 4);
      
    if(rand < 10) {
      
      directions[view].addPowerUp(0);
      
    }
    else if(rand < 15) {
      
      directions[view].addPowerUp(1);
      
    }
    else if(rand < 17) {
      
      directions[view].addPowerUp(2);
      
    }
    
  }
  
}


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
  
  return value.charAt(0);  
}

void setUpController() {
  
  XML xml = loadXML("arcade.xml");
  
  XML playerXML = xml.getChild("player");
  
  p = new Player(playerXML);
  
}

ArrayList<Score> highScores;

void readHighScores() {
  
  highScores = new ArrayList<Score>();
  
  String scores[] = loadStrings("scores.txt");
  
  String name;
  int score;
  
  for(int i = 0; i < scores.length; i++) {
    
    String line[] = split(scores[i], "\t");
    
    name = line[0];
    score = Integer.parseInt(line[1]);
    
    highScores.add(new Score(name, score));
    
  }
  
}

int textChoice, textWait;
char[] letter;

void readName() {
  
  noFill();
  
  textSize(height * 0.08);
  textAlign(CENTER, CENTER);
  
  float size = height / 10;
  
  for(int i = 0; i < letter.length; i++) {
    
    if(textChoice == i){
      stroke(0, 255, 0);
    }
    else{
      stroke(200);
    }
    
    rect(width / 9 * (3.33f + i), height * 0.8f, size, size);
    
    text(letter[i], width / 9 * (3.59f + i), height * 0.85f);
  }
  
  textWait++;
  
}

void addToScores() {
  
  String name = "";
  
  for(int i = 0; i < letter.length; i++) {
    
    name = name + letter[i];
    
  }
  
  highScores.add(new Score(name, p.score));
  sortScores();
  
  highScores.remove(highScores.size() - 1);
  
  String saveData = new String();
  
  for(int i = 0; i < highScores.size() - 1; i++) {
    
    saveData = saveData + (highScores.get(i).name + "\t" + highScores.get(i).score + "\tend");
    
  }
  
  saveData = saveData + (highScores.get(highScores.size() - 1).name + "\t" + highScores.get((highScores.size() - 1)).score);
  
  String[] list = split(saveData, "\tend");
  
  saveStrings("/data/scores.txt", list);
  
}

void sortScores() {
  
  Score temp;
  
  for(int i = 0; i < highScores.size(); i++) {
    
    for(int j = 1; j < highScores.size(); j++) {
      
      if(highScores.get(j).score > highScores.get(j - 1).score) {
          
          temp = highScores.get(j);
          highScores.set(j, highScores.get(j - 1));
          highScores.set(j - 1, temp);
          
        }
        
    }
    
  }
  
}
