/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 
int w_gridX, w_gridY;
int w_size = 10;
int w_seed = 0;
float w_prevAvg;
int w_counter;

void wSetup() { // custom setup = runs once
  myText = "w";
  //frameRate(5);
  w_gridX = width/w_size;
  w_size= height/50;
  easing =0.2;
  drawLaserLines = true;
}

void wDraw() { // custom draw = renders fooorever
  randomSeed(w_seed);
  //SETTINGS [change, but don't delete any]
  credits = "elias.hodel"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.8; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  //background(0); // default background
  backgroundFade(floor(map(avgAudio/w_prevAvg, 0, 1, 255, 0))); // very experimental.. sorta fails in 3D

  grp = RG.getText(myText.toUpperCase(), myTextFont, floor(myTextSize), CENTER); 
  grp = RG.centerIn(grp, g);
  float normAudio = norm(avgAudio, 0.2, maxAudio);
  //float normAudio=1;
  grp.scale(normAudio);
  grp.translate(width/2, height/2);

  RG.setPolygonizer(RG.ADAPTATIVE); // type of division 
  //pointPaths = grp.getPointsInPaths(); // [collection of characters] -> [collection of points] 
  stroke(255);
  //println(avgAudio, maxAudio, norm(avgAudio, 0, maxAudio));
  for (int x = 0; x<width; x += w_size) {


    int audioFreqIndex = floor(map(x, 0, width, 0, fft.avgSize()*0.66)); 
    float audioFreq = fft.getAvg(audioFreqIndex)*amp; 
    println(norm(audioFreq, 0, maxAudio));
    for (int y = 0; y<height; y+= w_size) {
      RPoint p = new RPoint(x+w_size/2, y+w_size/2);
      if (grp.contains(p)) {
        if (w_counter % ceil(normAudio*normAudio*40) ==0) {
          xline(x, y, x+w_size, y+w_size);
        } else {
          stroke(255);
          line(x, y, x+w_size, y+w_size);
          //xstroke(255,200,0);
          //if(x%ceil(normAudio*5)==0 && y%ceil(normAudio*5)==0){ // **fix scale to # of lines
          //}
        }
        w_counter++;
      } else {
        float dist = dist(x,y,width/2,height/2);
        float max_dist = dist(0,height/2,width/2,height/2);
        stroke(255,map(dist,0,max_dist,255,30));

        if (norm(audioFreq, 0, maxAudio*10)<random(0, .6)) {
          line(x, y+w_size, x+w_size, y);
        } else {
          line(x, y, x+w_size, y+w_size);
        }
      }
    }
  }


  if (pointPaths != null) { // draw if points ready
  } // if pointsPath
  w_prevAvg = avgAudio;
  w_counter =0;
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/