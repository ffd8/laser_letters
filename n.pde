/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
float na = 0 ; 
float nb = 0 ; 

void nSetup() { // custom setup = runs once
}

void nDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "Victor.Bringolf"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.6; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15 ;// custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D
  pushMatrix();

  //println(easeAudio);


  translate(width/2, height/2, 0);
  float whatEver = map(easeAudio, 0, 100, 0, 2.5);
  scale(whatEver/2, whatEver/2);
  println(easeAudio);


  na = maxAudio-1;
  nb = nb + easeAudio/2;

  if (avgAudio >= maxAudio-1) {
    rotateZ(na/10);
    //rotateX(a/10);
    //rotateY(a/10);
  } else {
    rotateZ(nb);
    rotateY(nb);
    //rotateZ(b);
  }

  // suggestion to draw from center out 

  if (pointPaths != null) { // draw if points ready 

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();

      int audioFreqIndex = floor(map(i, 0, pointPaths[i].length, 0, fft.avgSize())); 
      float audioFreq = fft.getAvg(audioFreqIndex)*amp; 
      
      strokeWeight(whatEver);
        stroke(255);
      beginShape(); // just demo shape below!
      for (int j=0; j < pointPaths[i].length; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
        float audioWave = in.left.get(audioWaveIndex)*ampWave*.5;
        vertex(pointPaths[i][j].x + audioWave, pointPaths[i][j].y+audioWave);
        
      } // j

      endShape();

      pushMatrix();
      translate (0, 0, width/2);
      strokeWeight(whatEver*2);
      beginShape(); // just demo shape below!
      for (int j=0; j < pointPaths[i].length; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 
        
        vertex(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave);

        stroke(255);
      } // j

      endShape();

      popMatrix();


      for (int j=0; j < pointPaths[i].length; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 
        strokeWeight (whatEver/2);
        line(pointPaths[i][j].x + audioWave, pointPaths[i][j].y + audioWave*10, 0, pointPaths[i][j].x, pointPaths[i][j].y, audioWave*10);

        //stroke(255);
        stroke(255);
      } // j


      //LASER
      float audioColor = map(easeAudio, 0, 100, 50, 255);
      float audioColor2 = map(easeAudio, 0, 100, 255, 50);
      xstroke(audioColor, audioColor2, 0);
      xbeginShape();
      for (int j=0; j < pointPaths[i].length; j+=1) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 

        xvertex(pointPaths[i][j].x + audioWave, pointPaths[i][j].y + audioWave*2, 0);
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y, audioWave*2);
        //line(pointPaths[i][j].x + audioWave, pointPaths[i][j].y + audioWave, 0, pointPaths[i][j].x, pointPaths[i][j].y, audioWave*20);
        //strokeWeight (whatEver);
        //stroke(255);
      } // j
      xendShape();
    } // i
  } // if pointsPath

  popMatrix();
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/