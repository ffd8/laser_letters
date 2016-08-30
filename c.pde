/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 


float cbass; 
float cmid; 
float chigh;
int czoom = 200;
boolean czoomdir = true;

void cSetup() { // custom setup = runs once
}

void cDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "Linda.Walter + Madelene.Imhof"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.75; // <- custom size
  myTextLength = 15; // <- custom length for cuts
  processType(); // <- function below (comment out if you prefer custom)
  background(0); // <- up to you if you want a background!
  //backgroundFade(20); // prefer fade?

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 
  scale(.65); // <- custom scale of letters

  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 
    //stroke(255); // optional...
    if (czoom == 500) {
      czoomdir = false;
    } else if (czoom == 200) {
      czoomdir = true;
    }

    if (czoomdir == true) {
      czoom += 2.5;
    } else {
      czoom -= 2.5;
    } 

    for (int i = 0; i < pointPaths.length; i++) { 
      beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 

        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 

        //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 10, 10); // try other shapes 
        // [i] refers to which character, [j] refers to which point in that character

        cbass = fft.calcAvg(20, 400)*amp; // fft.calcAvg(minFreq, maxFreq)  
        cmid = fft.calcAvg(400, 3000)*amp;  
        chigh = fft.calcAvg(3000, 10000)*amp;  

        pushMatrix(); 

        //C Laser

        if (j%3==0) {
          //stroke( 255);
          rotateY(radians(frameCount*0.3));
          //rect(pointPaths[i][j].x, pointPaths[i][j].y, cbass/30+5, cbass/30+5);
          xstroke( 100, 0, 200);
          xrect(pointPaths[i][j].x, pointPaths[i][j].y, cbass/2+5, cbass/2+5);
        }

        //gewuusel 1
        noFill();
        stroke(random(255), 80);         
        //float cSizeXw = map(pointPaths[i][j].x, 0, 800, 0, czoom);
        //float cSizeYw = map(pointPaths[i][j].y, 0, 800, 0, czoom);
        rotateX(radians(frameCount*audioWave/chigh/2));
        rect(pointPaths[i][j].x*3, pointPaths[i][j].y*3, 5, chigh/80);
        //rect(cSizeXw*5, cSizeYw*5, 5, chigh/80);
        rectMode(CENTER);

        popMatrix();



        pushMatrix();


        if (j%2==0) {
          //Grosses C Punkte
          noFill();
          stroke(random(255), 85);
          float cSizeXr = map(pointPaths[i][j].x, 0, 800, 0, easeAudio*2+1000);
          float cSizeYr = map(pointPaths[i][j].y, 0, 800, 0, easeAudio*2+1000);
          ellipse(cSizeXr, cSizeYr, 10, 10);
          // rotateY(radians(frameCount*0.1);
        } else {
          //czoom C
          noFill();
          stroke(random(255), 75);
          float cSizeXg = map(pointPaths[i][j].x, 0, 800, 0, czoom);
          float cSizeYg = map(pointPaths[i][j].y, 0, 800, 0, czoom);
          rect(cSizeXg+audioWave/2, cSizeYg, czoom/50, czoom/50);
        }



        //C bewegung1
        stroke(random(250));
        rotateX(radians(frameCount*0.5));
        rect(pointPaths[i][j].x*1.5, pointPaths[i][j].y*1.5+audioWave/2, random(5), random(20));

        //C bewegung 2  
        stroke(random(250));
        rotateZ(radians(frameCount*4.5));
        rotateY(radians(frameCount*1));
        rect(pointPaths[i][j].x*2, pointPaths[i][j].y*2+audioWave/2, 5, 5);




        popMatrix();



        //line(pointPaths[i][j].x, pointPaths[i][j].y+audioWave, random(5), random(20));
        //line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y, random(5), random(20));
      } 

      endShape();
    }
  }

  popMatrix();
}


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/