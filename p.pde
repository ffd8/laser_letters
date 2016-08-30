/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
float easeMax;
float xPos;
float yPos;
float easeX;
float easeY;

float maxXY;

float pprevAvg = 0;


void pSetup() { // custom setup = runs once
  drawLaserLines = true;
  rectMode(CORNER);

}

void pDraw() { // custom draw = renders fooorever

  float targetX_max = maxAudio;
  float dx_max = targetX_max - easeMax;
  easeMax += dx_max*easing;



  //SETTINGS [change, but don't delete any]
  credits = "elias.hodel"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.25; // <- custom size
  myTextLength = 25; // <- custom length for cuts
    useLowerCase = false; // *NEW* optionally set true for lowercase

  //processType(); // <- function below (comment out if you prefer custom)
  //background(0); // <- up to you if you want a background!
  backgroundFade(60); // prefer fade?
  pushMatrix();
  grp = RG.getText(myText.toUpperCase(), myTextFont, floor(myTextSize), CENTER); 
  grp = RG.centerIn(grp, g);
  grp.scale(.5);

  grp.translate(width/2, height/2);

  stroke(255, 255);
  noFill();
  RG.setPolygonizer(RG.ADAPTATIVE); // type of division 
  //RG.setPolygonizerLength(map(mouseY, 0, height, 100, 0)); // size of divisions 
  pointPaths = grp.getPointsInPaths(); // [collection of characters] -> [collection of points] 
  //println(frameCount);

  //grp.draw();
  println(easeAudio, easeMax);
  int step =floor(map(easeAudio, 0, easeMax, height/10, 1));
  if (step <1) {
    step=1;
  }
  //step =10;
  println(step);
  if (avgAudio>1) {
    for (int i = 0; i< width; i+=step) {
      stroke(255);
      //line(i+map(sin(radians(map(i,0,width-1,0,5*360)+frameCount)),-1,1,-step,step), 0, i+map(sin(radians(map(i,0,width-1,0,5*360)+frameCount)),-1,1,-step,step), height);
      line(i, 0, i, height);
      //  for (int i = 0; i< width; i+=10) {
      RShape cuttingLine = RG.getLine(i+map(sin(radians(map(i, 0, width-1, 0, 5*360)+frameCount)), -1, 1, -step, step), 0, i+map(sin(radians(map(i, 0, width-1, 0, 5*360)+frameCount)), -1, 1, -step, step), height);
      RG.shape(cuttingLine);

      //noStroke();

      // Get the intersection points
      RPoint[] ps = grp.getIntersections(cuttingLine);

      if (ps != null) {
        float y[] = new float[ps.length];
        for (int j=0; j<ps.length; j++) {
          y[j] = ps[j].y;

        }
        y= sort(y);
        for (int j=1; j<y.length; j+=2) {
          float offset = noise(i*j+frameCount*0.1)*40;
          //float offset =0;
         
          xline(i, y[j]+offset, i, y[j-1]+offset);
        }


        if (avgAudio>pprevAvg*6 && pprevAvg>0.1) {
          fill(255, 180);
          //rect(0,0, width, height);
        }
      }
    }
  }






  popMatrix();
  pprevAvg = avgAudio;

}


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/