/*---- YOUR CUSTOM CODE BELOW --------------------------*/
import java.util.Iterator;
float acc =0;



class ParticleSystem {
  ArrayList particles;
  PVector origin;
  PVector dir;
  float speed;
  PVector wiggle;

  ParticleSystem(PVector location, PVector dir_, float speed_, PVector wiggle_) {
    origin = location.copy();
    dir = dir_.copy();
    particles = new ArrayList();
    speed = speed_;
    wiggle = wiggle_.copy();
  }



  void addParticle() {

    particles.add(new Particle(origin, dir, speed, wiggle));
  }

  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.update();
      p.display();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
}



class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean laser;
  //PVector wiggle;

  Particle(PVector l, PVector dir_, float speed_, PVector wiggle_) {
    //[offset-up] For demonstration purposes we assign the Particle an initial velocity and constant acceleration.
    acceleration = new PVector(0, acc);
    //velocity = new PVector(random(-1,1),random(-2,0));
    velocity = dir_.copy().setMag(speed_).add(random(-wiggle_.x, wiggle_.x), random(wiggle_.y));
    location = l.copy();
    if (random(1)<0.005) {
      laser = true;
    }
  }

  // Sometimes it’s convenient to have a “run”
  // function that calls all the other functions we need.
  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void display() {
    stroke(255);
    fill(0);
    if (laser) {
      xellipse(location.x, location.y, rad, rad);
    } else {
      ellipse(location.x, location.y, rad*2, rad*2);
    }
    //point(location.x, location.y);
  }

  // Is the Particle alive or dead?
  boolean isDead() {
    if (location.x >width || location.x <-10 || location.y > height || location.y < -10) {
      return true;
    } else {
      return false;
    }
  }
}

/*---- PUT OWN VARIABLES JUST BEFORE customSetup()-----*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 
int numPS = 50;
float rad =2;
//ParticleSystem ps = new ParticleSystem(new PVector(150, -rad));
ParticleSystem[] ps; 
PVector direction = new PVector(0, 1);
float speed = 2;

float wiggleX = speed/10;
float wiggleY = speed/10;

float x1 = 200;
float y1 = 20;
float x2 = 200;
float y2 = 400;
int clickCounter =0;

float xOffset;
float yOffset;
//int numLines = 20;


float radPS;
float angle;

float prevAvg = 0;
boolean movie = false;
void xSetup() { // custom setup = runs once
  rad = round(height/300.0);
  speed = rad;
  numPS = round(height/10.0);
  angle = radians(360/float(numPS));
  radPS = height/4;
  easing = 0.05;
  ps =new ParticleSystem[numPS];
  for ( int i = 0; i<ps.length; i++) {
    float xTemp = width/2 + cos(angle*i)*radPS;
    float yTemp = height/2 + sin(angle*i)*radPS;
    PVector wiggleInit = new PVector(wiggleX, wiggleY);

    ps[i] = new ParticleSystem(new PVector(xTemp, yTemp), new PVector(0, 1).rotate(angle*i), speed, wiggleInit);
    drawLaserLines = true;
  }
}

void xDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "elias.hodel"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height/3.5; // <- custom size
  myTextLength = 1; // <- custom length for cuts
  processType(); // <- function below (comment out if you prefer custom)
  //background(0); // <- up to you if you want a background!
  backgroundFade(20); // prefer fade?
  //speed = map(easeAudio,0,maxAudio,.5,10);
  
  
  //wiggleX = speed/10;
  //wiggleY = speed/10;
  println(avgAudio, easeAudio, avgAudio-easeAudio);

  strokeWeight(1);
  for (int i = 0; i< ps.length; i++) {
    //ps[i].speed = speed+map(avgAudio-easeAudio,-avgAudio,avgAudio,0,1);
    ps[i].speed = speed + (avgAudio-prevAvg)/5;
    if (ps[i].speed>-speed && ps[i].speed<0) {
      ps[i].speed = -speed;
    } else if (ps[i].speed< speed && ps[i].speed >=0) {
      ps[i].speed = speed;
    }
    ps[i].dir.set(new PVector(0, 1).rotate(angle*i+radians(map(avgAudio, 0, easeAudio, 0, -25))));
    //ps[i].run(lines);
    ps[i].run();
    if (frameCount%10== 0 || avgAudio>prevAvg*2) {
      ps[i].addParticle();
    }
  }
  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2, 0); // suggestion to draw from center out 
  rotate(radians(-frameCount*1)); // changed from 2 = slow = better for laser keep up
  //scale(.3);


  strokeWeight(1.5);

  if (pointPaths != null) { // only draw if points ready 
    //noFill(); // optional.. 

    for (int i = 0; i < pointPaths.length; i++) { 
      //noFill();
      stroke(255); // optional...

      //fill(255); // optional...
      xbeginShape(); 

      for (int j=0; j < pointPaths[i].length; j++) { 

        xvertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      } 
      xendShape();
    }
  }


  popMatrix();

  prevAvg = avgAudio;
  //if (movie) {
    //saveFrame("movie/output#####.png");
  //}
}

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/