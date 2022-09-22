//Simple clone game of Whack-A-Mole
//C. Song

//SoundFile file;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim       minim;
AudioPlayer victory;

PFont font;
PImage menu;
PImage slap;
PImage meerkat;
PImage smashed;
int stage; /*This is to indicate the start screen or the play area
-->the site that gave the info //https://forum.processing.org/two/discussion/20024/urgent-please-i-want-to-create-a-startscreen-for-my-pong-game-what-am-i-doing-wrong
*/
int x;
int y;
int x1;
int y1;
int x2;
int y2;
int lastTime;
int counter = 30; /*Counter equals the amount of time a player has to slap the meerkats
-->this could also be in void setup();*/
int lastCounter;
int delayAmount;
int diameter = 120;
int score = 0;
//the use of boolean for datatype to be either true or false, useful for the program to 
boolean whack = false;
boolean whacked1 = false;
boolean whacked2 = false;
boolean clickScore = false;

//Create window
void setup() 
{
  //Soundfile from the data folder of the sketch
  minim = new Minim(this);
  victory = minim.loadFile("music.wav"); //The music file is loaded into memory
  victory.loop(); //Sounfile is played in a loop
  victory.setGain(-7);//This decreases the volume of the original music track
  
  stage = 1;
  size(1350,850);
  lastCounter = millis(); //this returns the time in milliseconds
  speed();
  smooth();
  noStroke();
  noCursor();
  
  //Loading images and image resizing 
  menu = loadImage ("menu.jpg");
  menu.resize(1350,850); //this resizes the image to fit the whole screen
  slap = loadImage ("slap.png");
  slap.resize(0,120);
  meerkat = loadImage ("meerkat.png");
  meerkat.resize(0,120);
  smashed = loadImage ("smashed.png");
  smashed.resize(0,1);
}//end

void draw() 
{
  if (stage == 1){ //if stage is 1 it will display the start screen
    background(menu);
    fill(0,0,0);
    textSize(60);
    text("Welcome to Slap the Kat!", 270, 200);
    textSize(30);
    text("Press any key to start the game", 440, 300);
    if (keyPressed == true){ //when any key is pressed, the stage is 2
      stage = 2;
    }
  }
  else if (stage == 2){ //when stage is 2 the start screen changes to the play area 
    background(240, 203, 38);
    stroke(0);
    fill(206, 169, 5);
    //Drawing of the 9 holes
    //First row of holes
    ellipse(180,300,174,40);
    ellipse(680,300,174,40);
    ellipse(1180,300,174,40);
    //Second row of holes
    ellipse(180,500,174,40);
    ellipse(680,500,174,40);
    ellipse(1180,500,174,40);
    //Third row of holes
    ellipse(180,700,174,40);
    ellipse(680,700,174,40);
    ellipse(1180,700,174,40);
    
    /*Kayla Arias inspired code
    -->this part was inspired by Kayla Arias on the openprocessing.org because it was
    a bit difficult to get the images of meerkats to appear in specific location but randomly
    -->this piece of code displays the meerkats only when the player whacks the area where meerkats show up*/
    if (whack == true) {
      image(smashed, x, y);
    } 
    else {
      image(meerkat, x, y);
    }
    if (whacked1 == true) {
      image(smashed, x1, y1);
    } 
    else {
      image(meerkat, x1, y1);
    }
    if (whacked2 == true) {
      image(smashed, x2, y2);
    } 
    else { 
      image(meerkat, x2, y2);
    }
    
    /*The slapping of meerkats
    -->processing.org has info on this piece of code
    -->the image of the hand is rotated -25 and the popMatrix() allows the hand to have the push/pop effect
    */
    pushMatrix();
    if (mousePressed) {
      rotate(-25);
    }
    image(slap, mouseX-50, mouseY-120);
    popMatrix();
    
    //Play area screen
    font = loadFont("SnapITC-Regular-48.vlw");
    fill(255, 104, 19);
    textFont(font,32);
    textSize(26);
    text("Score: "+score, 800, 800);
    text("Time: "+counter, 400, 800);
    textSize(60);
    text("Slap the Kat!", 450, 100);
    
    /*Kayla Arias inspired code
    -->as mentioned it was difficult to get the meerkats to appear in specific locations but randomly
    -->if mousePressed then the click will have to be within the diameter of the meerkat
    */
    if ((mousePressed == true) && (dist(mouseX, mouseY, x, y) <= diameter)) {
      whack = true;
    }
    else {
      whack = false;
    }
  
    if ((mousePressed == true) && (dist(mouseX, mouseY, x1, y1) <= diameter)) {
      whacked1 = true;
    }
    else {
      whacked1 = false;
    }
  
    if ((mousePressed == true)  && (dist(mouseX, mouseY, x2, y2) <= diameter)) {
      whacked2 = true;
    }
    else {
      whacked2 = false;
    }
     
    if (millis() - lastTime > delayAmount) {
      //Meerkats appear randomly in specific loacations
      int randomMole= int (random(1, 10)); //From locations 1-10 the meerkats are appearing randomly
      if (randomMole == 1) 
      {
        x = 140;
        y = 175;
        x1 = 1140;
        y1 = 375;
        x2 = 1140;
        y2 = 175;
      }
  
      if (randomMole == 2) 
      {
        x = 640;
        y = 175;
        x1 = 1140;
        y1 = 575;
      }
  
  
      else if (randomMole == 3) 
      {
        x = 1140;
        y = 175;
        x1 = 1140;
        y1 = 375;
      }
  
  
      else if (randomMole == 4) 
      {
        x = 140;
        y = 375;
      }
  
  
      else if (randomMole == 5) 
      {
        x = 640;
        y = 375;
      }
  
      else if (randomMole == 6) 
      {
        x = 1140;
        y = 375;
      }
      else if (randomMole == 7) 
      {
        x = 140;
        y = 575;
        x1 = 140;
        y1 = 175;
        x2 = 1140;
        y2 = 575;
      }
      else if (randomMole == 8) 
      {
        x = 640;
        y = 575;
      }
      else if (randomMole == 9) 
      {
        x = 1140;
        y = 575;
      } 
      else if (randomMole == 10) 
      {
        x = 140;
        y = 175;
        x1 = 1140;
        y1 = 375;
        x2 = 1140;
        y2 = 175;
      }
      speed();//this controls the speed of the meerkats popping out
    }
    
    /*Timer countdown 
    -->Processing.org has this info
    -->int lastCounter minus the int lastCounter less than 1000*/
    if (millis() - lastCounter > 1000) {
      counter -= 1; //counter = counter -1; --> same as -=
      lastCounter = millis(); //lastCounter in milliseconds
    }
    /*A mistake in the program i wasn't able to fix on my own
    -->a meerkat appears in the top left corner for some reason
    -->i tried to use this piece of code which covers it up*/
      noStroke();
      fill(240, 203, 38);
      rect(0,0,100,150);
    
    /*I needed help on this part of the code
    -->the timer was going backwards negatively
    -->paulgoux on discourse.openprocessing.com forum helped resolve this
    -->the mistake was if(counter == 0) which i changed to if(counter <= 0) to fix it
    -->counter had to be less than or equal for the timer to not get backwards negatively 
    even after displaying game over screen*/ 
    if (counter <= 0){//when time is less than or equal it will display game over screen
      background(0);
      cursor();
      textSize(50);
      text("Game Over", 540, 360);
      text("Score = " + score, 540, 410);
      
      //This piece of is for the replay button on the game over screen
      //Draw replay button
      rectMode(CENTER);
      fill(255);
      rect(680, height-380, 150, 50, 7);
      fill(0, 0, 0);
      textSize(30);
      text("Replay?", 615, height-370);
      
      //Click to replay the game
      if (mousePressed) {
        if (mouseX > (width/2 - 75) &&  mouseX < (width/2 + 75) && mouseY < height-380 + 25 && mouseY > height-380 - 25) {
        fill(0);
        rect(670, height-380, 150, 50, 7);
        reset();//if the replay button is clicked the game resets 
        }
      }
      
      //This piece of is for the exit button on the game over screen
      //Draw exit button
      rectMode(CENTER);
      fill(255);
      rect(680, height-280, 100, 50, 7);
      fill(0, 0, 0);
      textSize(30);
      text("Exit", 640, height-270);
      
      //Click to exit the game
      if (mousePressed) {
        if (mouseX > (width/2 - 75) &&  mouseX < (width/2 + 75) && mouseY < height-280 + 25 && mouseY > height-280 - 25) {
        fill(0);
        rect(680, height-280, 100, 50, 7);
        exit();//like the ball and bat lab, exit() is used here to click off the game
        }
      }
    }
  } 
}//end

/*Discourse.openprocessing.com has this info
-->the speed of the meerkat appearing is controlled by this void speed()
*/
void speed() {
  lastTime = millis();
  delayAmount = int(random(1, -2) * 1000);
}

/*This is what happens when replay button is clicked on
-->everything will be like the start of the game, score is 0 and timer is starts from 30 secs
*/
void reset() {
  score = 0;
  counter = 30;
  noStroke();
  noCursor();
}

/*Discourse.openprocessing.org has this info
-->for each click on the meerkat, the score is added by 1
*/
void mouseClicked() {
  clickScore = true;
  if ((clickScore == true) && (whack == true)) {
    score += 1; //could also be score = score +1
  }
  if ((clickScore == true) && (whacked1 == true)) {
    score += 1;
  }
  if ((clickScore == true) && (whacked2 == true)) {
    score += 1;
  }
}
