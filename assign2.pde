PImage bg;
PImage groundhog;
PImage life;
PImage soil;
PImage soldier;
PImage title;
PImage startNormal;
PImage restartNormal;
PImage startHovered;
PImage restartHovered;
PImage cabbage;
PImage gameOver;
PImage groundhogDown,groundhogRight,groundhogLeft;

boolean downPressed=false,leftPressed=false,rightPressed=false;
boolean downMove=false,rightMove=false,leftMove=false,move=false;

float soldierX;//set soldier's posititon
float soldierY;

int groundhogX,groundhogY;
int groundhogDownX=1000,groundhogDownY=-1000;
int groundhogLeftX=1000,groundhogLeftY=-1000;
int groundhogRightX=1000,groundhogRightY=-1000;
int distance;
int cabbageX,cabbageY;
int lifeNumber;
int life1X=10,life2X=80,life3X=640;

int gameState;
final int GAME_RUN=0,GAME_START=1,GAME_WIN=2,GAME_LOSE=3;

void setup() {
	size(640, 480, P2D);	
  //load images
  bg = loadImage("img/bg.jpg"); 
  groundhog = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  title = loadImage("img/title.jpg");
  gameOver = loadImage("img/gameover.jpg");
  
  cabbage = loadImage("img/cabbage.png");
  cabbageX = 80*floor(random(0,8));
  cabbageY = 80*floor(random(2,6));
  
  soldier = loadImage("img/soldier.png");
  soldierX = 0;
  soldierY = 80*floor(random(2,6));
  
  startNormal = loadImage("img/startNormal.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartHovered = loadImage("img/restartHovered.png");
  
  lifeNumber = 2;
  groundhogX=320;groundhogY=80;
  //gamerun
  gameState = GAME_RUN;
}

void draw() {
	// Switch Game State
  switch(gameState){
    // Game RUN
    case GAME_RUN:
      image(title,0,0);
      image(startNormal,248,360);
      
      if(mouseX>248&&mouseX<392
      &&mouseY>360&&mouseY<420){
        image(startHovered,248,360);
        if(mousePressed){
          gameState = GAME_START;
        }  
      }  
    break;
		// Game START
    case GAME_START:
      image(bg,0,0);
      image(soil,0,160);
      image(cabbage,cabbageX,cabbageY);
      //grass
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      image(groundhog,groundhogX,groundhogY);
      image(groundhogDown,groundhogDownX,groundhogDownY);
      image(groundhogLeft,groundhogLeftX,groundhogLeftY);
      image(groundhogRight,groundhogRightX,groundhogRightY);
      
      image(life,life1X,10);
      image(life,life2X,10);
      image(life,life3X,10);
      image(soldier,soldierX-80,soldierY);//soldier runs
      soldierX=(soldierX+5)%720;
      if(move){
        if(downPressed){        
          groundhogDownY+=5;
          groundhogDownY=min(groundhogDownY,400);
          distance+=5;
          if(distance==80){
            move = false;
            groundhogY = groundhogDownY;
            groundhogX = groundhogDownX;
            groundhogDownX = 1000;
            distance = 0;
            downPressed = false;
          }        
         }
         if(leftPressed){
          groundhogLeftX-=5;
          groundhogLeftX=max(groundhogLeftX,0);
          distance+=5;
          if(distance==80){
            move = false;
            groundhogY = groundhogLeftY;
            groundhogX = groundhogLeftX;
            groundhogLeftX = 1000;
            distance = 0;
            leftPressed = false;
          }    
         }
          if(rightPressed){
            groundhogRightX+=5;
            groundhogRightX=min(groundhogRightX,560);
            distance+=5;
            if(distance==80){
              move = false;
              groundhogY = groundhogRightY;
              groundhogX = groundhogRightX;
              groundhogRightX = 1000;
              distance = 0;
              rightPressed=false;
            }
          }
        }
      
     
      
      if(groundhogX+80 > soldierX && groundhogX < soldierX & groundhogY+80 > soldierY && groundhogY < soldierY+80
      ||groundhogDownX+80 > soldierX && groundhogDownX < soldierX && groundhogDownY+80 > soldierY && groundhogDownY < soldierY+80
      ||groundhogLeftX+80 > soldierX && groundhogLeftX < soldierX && groundhogLeftY+80 > soldierY && groundhogLeftY < soldierY+80
      ||groundhogRightX+80 > soldierX && groundhogRightX < soldierX && groundhogRightY+80 > soldierY && groundhogRightY < soldierY+80){
        lifeNumber-=1;
        groundhogDownY=-1000;
        groundhogLeftY=1000;
        groundhogRightY=1000;
        groundhogX=320;
        groundhogY=80;
        move=false;
        distance = 0;
        downPressed=false;rightPressed=false;leftPressed=false;
      }
      if(groundhogX+80 > cabbageX && groundhogX < cabbageX+80 && groundhogY+80 > cabbageY && groundhogY < cabbageY+80
      ||groundhogDownX+80 > cabbageX && groundhogDownX < cabbageX+80 && groundhogDownY+80 > cabbageY && groundhogDownY < cabbageY+80
      ||groundhogLeftX+80 > cabbageX && groundhogLeftX < cabbageX+80 && groundhogLeftY+80 > cabbageY && groundhogLeftY < cabbageY+80
      ||groundhogRightX+80 > cabbageX && groundhogRightX < cabbageX+80 && groundhogRightY+80 > cabbageY && groundhogRightY < cabbageY+80){
        lifeNumber+=1;
        lifeNumber = min(3,lifeNumber);
        cabbageY=800;
      }
      if(lifeNumber==1){
          life2X=1000;
          life3X=1000;            
      }
      if(lifeNumber==2){
        life2X=80;
        life3X=1000;          
      }
      if(lifeNumber==0){
        gameState = GAME_LOSE;
        }
      if(lifeNumber==3){
        life2X=80;
        life3X=150;
      }
      //sun
      fill(253,184,19);
      strokeWeight(5);
      stroke(255,255,0);
      ellipse(590,50,120,120);
    break;
    // Game Lose
    case GAME_LOSE:
    image(gameOver,0,0);
    image(restartNormal,248,360);
    if(mouseX>248&&mouseX<392
      &&mouseY>360&&mouseY<420){
        image(restartHovered,248,360);
        if(mousePressed){
          lifeNumber = 2;
          groundhogX=320;groundhogY=80;
          groundhogDownY=-1000;groundhogRightY=1000;groundhogLeftY=1000;
          cabbageX = 80*floor(random(0,8));
          cabbageY = 80*floor(random(2,6));
          soldierX = 0;
          soldierY = 80*floor(random(2,6));
          distance = 0;
          move = false;
          downPressed=false;rightPressed=false;leftPressed=false;
          gameState = GAME_START;
        }
      }
    break;
}
}


void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case DOWN:
        if(move==false){
          groundhogDownY = groundhogY;
          groundhogDownX = groundhogX;
          groundhogX=1000;
          downPressed=true;
          move = true;
        }
      break;
      case RIGHT:
        if(move==false){
          groundhogRightY = groundhogY;
          groundhogRightX = groundhogX;
          groundhogX=1000;
          rightPressed=true;
          move = true;
        }
      break;
      case LEFT:
        if(move==false){
          groundhogLeftY = groundhogY;
          groundhogLeftX = groundhogX;
          groundhogX=1000;
          leftPressed=true;
          move = true;
        }
      break;
    }
  }
}


void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case DOWN:
        
        
        
      break;
      case RIGHT:
        
      break;
      case LEFT:
        
      break;
    }
  }
}
