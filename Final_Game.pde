import processing.sound.*;

ArrayList <Hunter> hunterList;
ArrayList <Trap> trapList;

int changingXSpeed = -6;

//background
PImage mountains;
PImage startScreen;
PImage endScreen;

//timer vars
boolean isState1;
int startTime;
int endTime;
int interval = 4000;
int score;

//animation stuff
Animation deerAnimation;
Animation hunterAnimation;
Animation trapAnimation;

//declaring sound var
SoundFile boop;
SoundFile backgroundMusic;

//variable class
Deer deer;
Hunter hunter;
Trap trap;

//finite machine
int state;

//animation images
PImage[] deerImages = new PImage [5];
PImage[] hunterImage = new PImage [1];
PImage[] trapImage = new PImage [1];

void setup() {
  size (1500, 800);

  //array list
  hunterList = new ArrayList <Hunter> ();
  trapList = new ArrayList <Trap> ();

//backgrounds
  mountains = loadImage ("artBackground.PNG");
  startScreen = loadImage ("rrBackground.PNG");
  endScreen =  loadImage ("endPage.PNG");

  //initialize startTime
  startTime = millis();
  isState1 = false;

  //initialize score
  score = 0;

  //initialize state var
  state = 0;
  //resize image
  mountains.resize(1500, 800);
  startScreen.resize (1500, 800);
  endScreen.resize (1500, 800);
  
///////////////////////////////SOUND STUFF///////////////////////////////////////////////////////////////

  boop = new SoundFile(this, "boop.wav");
  backgroundMusic = new SoundFile(this, "background.wav");

  //change speed of sound
  boop.rate(3.0);

  //change volume
  boop.amp(0.5);
  
//////////////////////////////////////  LOADING IMAGES ////////////////////////////////////////////////////////

  //call stuff with values
  deer = new Deer(120, height-70, 60, color(160, 123, 92)); //this starting height is good
  hunter = new Hunter(width, height-20, 50, 80, color(200, 0, 0));
  trap = new Trap (width, height-70, 20, 40, color (10));

  //load deer images
  for (int i = 0; i < deerImages.length; i = i + 1) {
    deerImages[i] = loadImage("deer" +i+ ".png");
  }

  //load hunter image
  for (int i = 0; i < hunterImage.length; i = i + 1 ) {
    hunterImage [i] = loadImage ("hunter" +i+ ".png");
  }

  //load trap image
  for (int i = 0; i < trapImage.length; i = i + 1 ) {
    trapImage [i] = loadImage ("trap" +i+ ".png");
  }


  //calling animations
  deerAnimation = new Animation (deerImages, .2, 4.); //image, speed, scale
  hunterAnimation = new Animation (hunterImage, .4, 4.);
  trapAnimation = new Animation (trapImage, .5, 9);
}
void keyPressed() {
  if (key == 'w' && deer.isJumping == false && deer.isFalling == false) {
    deer.isJumping = true;
    deerAnimation.isAnimating = false;
    deer.peakY = deer.dy - deer.jumpHeight;
    boop.play();
  }

  if (key == 'r') {
    changingXSpeed = -6;
    setup();
    state +=1;
  }
}
void draw() {
  //initialize endTime
  endTime = millis();
////////////////////////////////////  SPAWNING CHARACTERS AND SPEED  //////////////////////////////////////////////////////////
  if (endTime - startTime >= interval) {
    changingXSpeed = int (random(-7, -4));
    hunter = new Hunter(width, height-50, 50, 80, color(200, 0, 0));
    hunter.xSpeed=changingXSpeed;
    changingXSpeed -= 1;

    trap = new Trap (width, height-70, 20, 40, color (10));
    trap.xSpeed = changingXSpeed;

    startTime = millis(); 

    hunterList.add(hunter);
    trapList.add(trap);

//renders trap and hunter at random intervals
    interval = int( random(4000, 10000));
  }
//////////////////////////////////////  CASE 0: START SCREEN  ////////////////////////////////////////////////////////

  switch (state) {
    //start screen
  case 0:
    background(startScreen);
    break;

//////////////////////////////////  CASE 1: RUN GAME  ////////////////////////////////////////////////////////////

  case 1:
    if (backgroundMusic.isPlaying()==false) {
      backgroundMusic.play();
    }

    background (mountains);
    textSize(40);
    fill (255);
    text(score, 125, 50);
    text("Score:", 10, 50);

    //make time increase gradually
    score= score +1;

    if (backgroundMusic.isPlaying() == false) {
      backgroundMusic.play();
    }

    deerAnimation.display(deer.dx, deer.dy-70);
    deerAnimation.isAnimating = true;

    deer.render();
    deer.jump();
    deer.reachedTopOfJump();
    deer.fall();
    deer.land();
    println(deer.dBottom);

    trap.render();
    trap.move();

    //array list
    for (Hunter aHunter : hunterList) {
      aHunter.move();
      aHunter.collisionDetection(deer);
      hunterAnimation.display(aHunter.hx, aHunter.hy);
      hunterAnimation.isAnimating = true;
    }
    for (Trap aTrap : trapList) {
      aTrap.move();
      aTrap.collisionDetection (deer);
      trapAnimation.display(aTrap.tx, aTrap.ty);
      trapAnimation.isAnimating = true;
    }

    break;
    /////////////////////////////////////  CASE 2: END SCREEN  /////////////////////////////////////////////////////////

  case  2:
    if (backgroundMusic.isPlaying()==true) {
      backgroundMusic.stop();
    }
    background(endScreen);
    fill (255);
    text(score, 125, 50);
    text("Score:", 10, 50);


    break;
  }
}
