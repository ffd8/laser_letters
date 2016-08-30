// CC teddavis.org + students 2016
// built in Processing 3.1.1

/*---- SETTINGS  ---------------------------------------*/
//template ver. 05
char myKey = 'a'; // change this to your letter (and setup/draw below)
boolean showEQ = false; // for testing audio input
boolean drawLaserLines = true; // draws laser lines (final: will be off)
boolean fullScreenToggle = true; // toggle fullscreen (final: will be on)



/*---- SHARED CODE BELOW -----------------------------*/
/*---- LEARN HOW/WHY BELOW, IT STAYS SAME FOR ALL ----*/

//STRUCTURE
boolean doSetup = true;

//TYPE
import geomerative.*;  
RShape grp; 
RPoint[][] pointPaths; // 2D array = an array of arrays! 
PFont myFont;
String myTextFont = "FreeSans.ttf";
float myTextSize = 250;
float myTextLength = 25;
String myText = myKey+""; 
boolean shiftDown = false;
boolean useLowerCase = false;

//AUDIO
import ddf.minim.*;   
import ddf.minim.analysis.*;  
Minim minim;   
FFT fft;  
AudioInput in;  
float amp = 15; // from testing, 15 seems to be good...
float ampWave; // used to strengthen signal   
float avgAudio; // store avg volume  
float maxAudio = 10; // store loudest volume
float easeAudio; 
float easing = 0.25; // easing amount

//ANIMATION
String credits = "";
float creditsTimer = 0;

//TEASER
boolean showTeaser = false;
RShape tsgrp, tstsgrp2; 
RPoint[][] tspointPaths, tstspointPaths2; // 2D array = an array of arrays! 


void settings() {
  if (!fullScreenToggle) {
    size(800, 500, P3D);
  } else {
    fullScreen(P3D);
  }
}

void setup() {

  background(0);

  //TYPE
  RG.init(this);
  myFont = createFont("FreeSans.ttf", height*.020);

  //AUDIO
  minim = new Minim(this); // initalize in setup   
  in = minim.getLineIn(Minim.STEREO, 512); // audio in + bufferSize 512 or 1024 
  fft = new FFT(in.bufferSize(), in.sampleRate());  
  fft.logAverages(22, 3); // 3 = 30, 4 = 40, etc..
  ampWave = amp*10;
  noCursor();

  //LASER
  osc = new OscP5( this, 12346 );
  receiver = new NetAddress( "127.0.0.1", 12345 );
  frameRate(24);
}


void draw() {

  //LASER
  myBundle = new OscBundle();
  oscMSG = new OscMessage("/clear");  
  myBundle.add(oscMSG);
  oscMSG.clear();

  //AUDIO
  updateAvgAudio();

  pushMatrix();
  pushStyle();
  //SETUP
  if (doSetup) {
    useLowerCase = false; // defaults
    drawLaserLines = false; // defaults
    if(!showTeaser){
      method(Character.toLowerCase(myKey)+"Setup");
    }
    strokeWeight(1.35); 
    doSetup = false;
  }

  // DRAW DYNA-LOAD sketches as functions! 
  if(!showTeaser){
    method(Character.toLowerCase(myKey)+"Draw");
  }else{
    teaser();
  }
  popStyle();
  popMatrix();

  //CREDITS
  showCredits(); // <- put your name[s] there!
  if (showEQ) {
    drawEQ();
  }

  // SEND OSC » LASER
  osc.send(myBundle, receiver);
}

void calibrate() {
  pushStyle();
  strokeWeight(3);
  fill(255);
  stroke(255);
  line(-width/2, -height/2, width/2, height/2);
  line(-width/2, height/2, width/2, -height/2);
  float xb = 50;
  xstroke(150, 150, 0);
  xrectMode(CENTER);
  // xrect(0, 0, width/2, height/2);
  //xellipse(0,0,width/2, width/2);
  xline(-width/2+xb, -height/2+xb, width/2-xb, height/2-xb);
  xline(-width/2+xb, height/2-xb, width/2-xb, -height/2+xb);
  popStyle();
}

void xymode() {
  xstroke(0, 255, 0);
  xbeginShape();  
  for (int i = 0; i < in.bufferSize(); i+=2) {      
    float x = 1+in.left.get(i)*ampWave; // left audio channel 
    float y = 1+in.right.get(i)*ampWave; // right audio channel 
    xvertex(x, y); // use vertex(x, y); for straight lines
  }  
  xendShape();
}

void keyPressed() { 
println(keyCode);
  //AUDIO AMP
  
  if (keyCode == 38) { // up arrow 
    amp += 5; 
    ampWave = amp*10;
    return;
  } else if (keyCode == 40) { // down arrow 
    amp -= 5; 
    if (amp < 5) { 
      amp = 5;
    } 
    ampWave = amp*10;
    return;
  }
  

  if (keyCode >=65 && keyCode <= 95 && keyCode != 91 && keyCode != 92 && keyCode !=93) { // only A - Z  
    if (!shiftDown) {
      showTeaser = false;
      myKey = key;
      creditsTimer = 0;
      doSetup = true;
    }
    myText = key + ""; // replaces letter
  } else if (keyCode == 16) {
    shiftDown = true;
  } else if (keyCode == 8) {
    noLoop();
  } else if (keyCode == 32) {
    //saveShot();
    showTeaser = true;
  }else if(keyCode == 18 || keyCode == 17 || keyCode == 9 || keyCode == 157 || keyCode == 27){
    
  }else{
    myText = key + "";
  }
} 

void keyReleased() {
  if (keyCode == 16) {
    shiftDown = false;
  } else if (keyCode == 8) {
    loop();
  }
}

// UPDATE AUDIO INPUTS
void updateAvgAudio() {
  fft.forward(in.mix); // update FFT anaylsis 
  for (int i = 0; i < fft.avgSize (); i++) { 
    avgAudio+= abs(fft.getAvg(i)*amp); // duplicate everything for stereo w/ right too!
  }     
  avgAudio /= fft.avgSize();

  // update easeAudio
  float targetX = avgAudio; // grabs latest avgAudio 
  float dx = targetX - easeAudio; // calculates difference to current easeAudio 
  easeAudio += dx * easing;

  // update maxAudio
  if (frameCount%120 == 0) {
    maxAudio = 10;
  } else if (avgAudio > maxAudio) {
    maxAudio = avgAudio;
  }
}

// poor mans faded BG
void backgroundFade(int alpha) { 
  pushMatrix();
  pushStyle();
  noStroke(); 
  fill(0, alpha); // fill(color, alpha) 
  rectMode(CORNER);
  rect(0, 0, width, height); // background-like, but with alpha = poor mans fade!
  popStyle();
  popMatrix();
} 


// optional EQ for testing inputs
void drawEQ() {
  for (int i=0; i < fft.avgSize (); i++) {  
    float x = map(i, 0, fft.avgSize(), 0, width); 
    float w = width/fft.avgSize(); 
    float a = fft.getAvg(i)*amp; 

    noFill();
    stroke(a);
    rect(x, height, w, -a); // -a to make rectangle grow upwards!
  }

  fill(255);
  text("avgAudio", width-100, 40);
  rect(width, 50, -avgAudio, 50);
  text("easeAudio", width-100, 140);
  rect(width, 150, -easeAudio, 50);
  text("maxAudio", width-100, 240);
  rect(width, 250, -maxAudio, 50);
  noFill();
}

// update TYPE
void processType() {
  if (!useLowerCase) {
    myText = myText.toUpperCase();
  }
  grp = RG.getText(myText, myTextFont, 250, CENTER); 
  grp = RG.centerIn(grp, g, constrain(map(myTextSize, 0, height, height*.5, 0), 0, height*.5));
  RG.setPolygonizer(RG.UNIFORMLENGTH); // type of division 
  RG.setPolygonizerLength(myTextLength); // size of divisions 
  pointPaths = grp.getPointsInPaths(); // get coordinates for every point
}

// CREDITS
PGraphics creditsPG;
void showCredits() {
  creditsPG = createGraphics(int(width*.25), int(height*.5));
  creditsPG.beginDraw();
  creditsPG.fill(255);
  creditsPG.textFont(myFont);
  creditsPG.textLeading(height*.03);

  String info = "\n\n---------------------\n[a – z] » visualization \nSHIFT + [a – z] » letter \n↑ – ↓ » audio sensitivity"; //  \nspace » snapshot";
  creditsPG.text("THE BASEL SCHOOL OF DESIGN \nINTRODUCTION MEDIUM II – 2016 \nPROCESSING – LASER LETTERS \n\n---------------------\n"+credits.toUpperCase() + info.toUpperCase(), 20, 40); 
  creditsPG.text("THE BASEL SCHOOL OF DESIGN \nINTRODUCTION MEDIUM II – 2016 \nPROCESSING – LASER LETTERS \n\n---------------------\n"+credits.toUpperCase() + info.toUpperCase(), 20, 40); 

  creditsTimer += 2;
  if (creditsTimer > 255) {
    creditsTimer = 255;
  }
  creditsPG.endDraw();
  tint(255-creditsTimer);
  if (creditsTimer < 255) {
    image(creditsPG, 0, 0);
  }
}

void saveShot() {  
  String date = new java.text.SimpleDateFormat("yy_MM_dd_kkmmss_SSS").format(new java.util.Date ()); 
  saveFrame("ll_snapshots/ll_"+date+".png");
}


// OSC LASER TALK
import oscP5.*;
import netP5.*;
OscP5 osc;
NetAddress receiver;
OscMessage oscMSG;
OscBundle myBundle;
int rectM;

// LASER FUNCTIONS

/***** stroke */
void xstroke(float r1, float g1, float b1) {
  if (drawLaserLines) {
    stroke(r1, g1, b1);
  }
  oscMSG = new OscMessage("/stroke");
  oscMSG.add(r1);
  oscMSG.add(g1);
  oscMSG.add(b1);
  myBundle.add(oscMSG);
  oscMSG.clear();
}

/***** rectMode */
void xrectMode(int c) {
  if (c == 0) {
    rectMode(CORNER);
    rectM = 0;
    oscMSG = new OscMessage("/rectMode");
    oscMSG.add(0);
    myBundle.add(oscMSG);
    oscMSG.clear();
  } else if (c == 3) {
    rectMode(CENTER);
    rectM = 3;
    oscMSG = new OscMessage("/rectMode");
    oscMSG.add(3);
    myBundle.add(oscMSG);
    oscMSG.clear();
  }
}

/***** rect */
void xrect(float x1, float y1, float w1, float h1) {
  if (!drawLaserLines) {
    noStroke();
  }

  if (rectM == 3) {
    x1 -= w1/2;
    y1 -= h1/2;
    w1 /= 2;
    h1 /= 2;
  }
  vertexRect(x1, y1, w1, h1);
}

void vertexRect(float x1, float y1, float w1, float h1) {
  xbeginShape();
  xvertex(x1, y1);
  xvertex(x1+w1, y1);
  xvertex(x1+w1, y1+h1);
  xvertex(x1, y1+h1);
  xvertex(x1, y1);
  xendShape();
}

/***** ellipse */
void xellipse(float x1, float y1, float w1, float h1) {
  if (!drawLaserLines) {
    noStroke();
  }

  vertexEllipse(x1, y1, w1, h1);
}

// vertexEllipse!
// based on http://stackoverflow.com/questions/5886628/effecient-way-to-draw-ellipse-with-opengl-or-d3d
void vertexEllipse(float cx, float cy, float rx, float ry) 
{ 
  int num_segments = 30;
  float theta = 2 * 3.1415926 / float(num_segments); 
  float c = cos(theta);//precalculate the sine and cosine
  float s = sin(theta);
  float t;

  float x = 1;//we start at angle = 0 
  float y = 0; 

  xbeginShape(); 
  for (int ii = 0; ii < num_segments+1; ii++) 
  { 
    //apply radius and offset
    xvertex(x * rx + cx, y * ry + cy);//output vertex 

    //apply the rotation matrix
    t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  } 
  xendShape();
}

/***** point */

void xpoint(float x1, float y1, float z1) {
  xpoint(x1, y1);
}
void xpoint(float x1, float y1) {
  if (!drawLaserLines) {
    noStroke();
  } else {
    point(x1, y1);
  }

  String shape = "point";
  //println(screenX(x2,y2));
  float x1out = map(screenX(x1, y1), 0, width, 0, 1);
  float y1out = map(screenY(x1, y1), 0, height, 0, 1);
  oscMSG = new OscMessage("/shape");
  oscMSG.add(shape);
  oscMSG.add(x1out);
  oscMSG.add(y1out);
  myBundle.add(oscMSG);
  oscMSG.clear();
}


/***** line */
void xline(float x1, float y1, float x2, float y2) {
  if (drawLaserLines) {
    //noStroke();
    line(x1, y1, x2, y2);
  } else {
  }

  String shape = "line";
  //println(screenX(x2,y2));
  float x1out = map(screenX(x1, y1), 0, width, 0, 1);
  float y1out = map(screenY(x1, y1), 0, height, 0, 1);
  float x2out = map(screenX(x2, y2), 0, width, 0, 1);
  float y2out = map(screenY(x2, y2), 0, height, 0, 1);
  oscMSG = new OscMessage("/shape");
  oscMSG.add(shape);
  oscMSG.add(x1out);
  oscMSG.add(y1out);
  oscMSG.add(x2out);
  oscMSG.add(y2out);
  myBundle.add(oscMSG);
  oscMSG.clear();
}

boolean vertexInit = false;
boolean vertexEnd = false;
ArrayList<PVector> v1;

/***** beginShape */
void xbeginShape() {
  vertexInit = true;
  v1 = new ArrayList<PVector>();
  oscMSG = new OscMessage("/beginShape");
  myBundle.add(oscMSG);
  oscMSG.clear();
}

void xcurveVertex(float x1, float y1) {
  xvertex(x1, y1);
}

void xcurveVertex(float x1, float y1, float z1) {
  xvertex(x1, y1, z1);
}

void xvertex(float x1, float y1) {
  float x1out = map(screenX(x1, y1), 0, width, 0, 1);
  float y1out = map(screenY(x1, y1), 0, height, 0, 1); 
  PVector vtemp = new PVector(x1, y1);
  v1.add(vtemp);
  oscMSG = new OscMessage("/vertex");
  oscMSG.add(x1out);
  oscMSG.add(y1out);
  myBundle.add(oscMSG);
  oscMSG.clear();
}

void xvertex(float x1, float y1, float z1) {
  float x1out = map(screenX(x1, y1, z1), 0, width, 0, 1);
  float y1out = map(screenY(x1, y1, z1), 0, height, 0, 1); 
  PVector vtemp = new PVector(x1, y1, z1);
  v1.add(vtemp);
  oscMSG = new OscMessage("/vertex");
  oscMSG.add(x1out);
  oscMSG.add(y1out);
  myBundle.add(oscMSG);
  oscMSG.clear();
}

/***** endShape */
void xendShape() {
  // CLOSE = 2
  if (!drawLaserLines) {
    noStroke();
  }
  beginShape();
  for (int i=0; i<v1.size(); i++) {
    PVector vtemp = v1.get(i);
    if (vtemp.z != 0) {
      vertex(vtemp.x, vtemp.y, vtemp.z);
    } else {
      vertex(vtemp.x, vtemp.y);
    }
  }
  endShape();
  vertexInit = false;
  oscMSG = new OscMessage("/endShape");
  myBundle.add(oscMSG);
  oscMSG.clear();
}

// TEASER
void teaser(){
  background(0); 

  //tsgrp = RG.getText("YES", "FreeSans.ttf", floor(width*.15), CENTER); 
  tsgrp = RG.loadShape("laserletters1.svg");
  tstsgrp2 = RG.loadShape("betabase3.svg");

  RG.setPolygonizer(RG.UNIFORMLENGTH); // type of division 
  RG.setPolygonizerLength(3); // size of divisions 
  tspointPaths = tsgrp.getPointsInPaths(); // [collection of characters] -> [collection of points] 
  tstspointPaths2 = tstsgrp2.getPointsInPaths(); // [collection of characters] -> [collection of points] 

  if (tspointPaths != null) { // only draw if we have points 
    noFill(); 
    stroke(255); 
    pushMatrix();
    translate(width*.52, height*.5); // where to draw points 
    rotateY(radians(sin(frameCount*.1)*15)); // sin(frameCount*.01)*20
    
    xstroke(0,0,map(sin(frameCount*.1),-1,1,50,255));
    noFill();
    int rval = 75;
    float yval = -height*.25;
    xbeginShape();
    xvertex(-width*.25,yval);
    xvertex(-width*.12,yval);
    xvertex(-width*.10,yval+random(-rval, rval));
    xvertex(-width*.08,yval);
    xvertex(-width*.06,yval+random(-rval, rval));
    xvertex(-width*.04,yval);
    xvertex(0,yval);
    xvertex(width*.25,yval);
    xendShape();
    stroke(255);
    
    
    // keep em separated, each letter it's own group! 
    for (int i = 0; i < tspointPaths.length; i++) { 

      if (i==int(frameCount%tspointPaths.length)) {
        //xstroke(255, 255, 255);
        xstroke(map(sin(frameCount*.1),-1,1,255,50),0,map(sin(frameCount*.1),-1,1,50,255));
        xbeginShape();
        for (int j=0; j < tspointPaths[i].length; j++) { 
          xvertex(tspointPaths[i][j].x, tspointPaths[i][j].y); // try other shapes
        }
        xendShape();
      }
      stroke(255);
      if (i!=7) {

        beginShape(); 
        for (int j=0; j < tspointPaths[i].length; j++) { 
          vertex(tspointPaths[i][j].x, tspointPaths[i][j].y); // try other shapes 
          vertex(tspointPaths[i][frameCount%tspointPaths[i].length].x, tspointPaths[i][frameCount%tspointPaths[i].length].y); // try other shapes
        } 
        endShape();
      }
    }

    int ss = 7;

    int kloops = 10;//int(frameCount*.1%10); //10; // 

    for (int k=0; k < kloops; k++) {
      pushMatrix();
      translate(-k*5, k*2.5, k*25);
      stroke(255);
      /*
      if (k==kloops-1) {
        xstroke(255, 0, 0);
        xbeginShape(); 
        for (int j=0; j < tspointPaths[ss].length; j++) {
          xvertex(tspointPaths[ss][j].x, tspointPaths[ss][j].y); //
        }
        xendShape();
      }
      */

      beginShape();
      for (int j=0; j < tspointPaths[ss].length; j++) { 
        vertex(tspointPaths[ss][j].x, tspointPaths[ss][j].y);
      } 
      endShape();
      popMatrix();
    }
    popMatrix();
  }

  if (tstspointPaths2 != null) { // only draw if we have points 
    noFill(); 
    pushMatrix();
    translate(width*.5, height*.5, 0); // where to draw points 
    //rotateY(radians(-25));
    rotateY(radians(sin(frameCount*.1)*-15));
    
   
    xstroke(map(sin(frameCount*.1),-1,1,255,50),0,0);
    noFill();
    int rval = 75;
    float yval = height*.25;
    xbeginShape();
    xvertex(-width*.25,yval);
    xvertex(-width*.05,yval);
    xvertex(0,yval+random(-rval, rval));
    xvertex(width*.05,yval);
    xvertex(width*.10,yval+random(-rval, rval));
    xvertex(width*.15,yval);
    xvertex(width*.20,yval);
    xvertex(width*.25,yval);
    xendShape();
    stroke(255);
    
   
    
        fill(255);

    for (int i = 0; i < tstspointPaths2.length; i++) { 

      /*
      if (i==int(frameCount*2%tstspointPaths2.length)) {
        xstroke(random(255), random(255), random(255));
        xbeginShape();
        for (int j=0; j < tstspointPaths2[i].length; j++) { 
          xvertex(tstspointPaths2[i][j].x, tstspointPaths2[i][j].y); // try other shapes
        }
        xendShape();
      }
      */

      noStroke();
      beginShape(); 
      for (int j=0; j < tstspointPaths2[i].length; j++) { 
        vertex(tstspointPaths2[i][j].x, tstspointPaths2[i][j].y); // try other shapes
      } 
      endShape();
    }
    popMatrix();
  }
}