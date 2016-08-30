/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void rSetup() { // custom setup = runs once
}

void rDraw() { // custom draw = renders fooorever

  float supererTurn = (maxAudio);

  //SETTINGS [change, but don't delete any]
  credits = "Lilian.Dolder"; // put your name[s] here!
  myTextFont = "No Parking.ttf"; // set font
  myTextSize = height*.6; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 60; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  pushMatrix(); // only adjusts translate/scale within matrix

  translate(width/2, height/2); // suggestion to draw from center out 
  rotateY(radians(frameCount*1));
  if (avgAudio>40) {
    //rotateY(ampWave*2);
  }

  if (pointPaths != null) { // draw if points ready 

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      stroke(255);

      beginShape(); // just demo shape below!
      for (int j=0; j < pointPaths[i].length; j++) { 

        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.right.get(audioWaveIndex)*ampWave;

        curveVertex(pointPaths[i][j].x+audioWave*4, pointPaths[i][j].y, 105);//floor(easeAudio)
        curveVertex(pointPaths[i][j].x+audioWave*4, pointPaths[i][j].y, 10);
      } // j
      endShape();

      /*
      // blink laser
       xstroke(random(55), random(100, 255), random(55, 150));
       xbeginShape(); // just demo shape below!
       for (int j=0; j < pointPaths[i].length; j++) { 
       
       int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
       float audioWave = in.right.get(audioWaveIndex)*ampWave;
       
       xcurveVertex(pointPaths[i][j].x+audioWave*4, pointPaths[i][j].y, 105);//floor(easeAudio)
       xcurveVertex(pointPaths[i][j].x+audioWave*4, pointPaths[i][j].y, 10);
       } // j
       xendShape();
       */
    } // i

    popMatrix();
  } // if points

  // cool laser
  
  pushMatrix(); // only adjusts translate/scale within matrix

  translate(width/2, height/2); // suggestion to draw from center out 
  rotateY(radians(frameCount*1));
  if (avgAudio>40) {
    //rotateY(ampWave*2);
  }

  if (pointPaths != null) { // draw if points ready 
    //float ablue = 
    xstroke(random(100), random(100, 255), random(55, 150));
    // xstroke map(avgAudio, 0, maxAudio, 0, 255),map(avgAudio, 0, maxAudio, 0, 255),map(avgAudio, 0, maxAudio, 0, 255);
    xbeginShape(); // just demo shape below!

    for (int i = 0; i < pointPaths.length; i+=1) {
      for (int j=0; j < pointPaths[i].length; j+=50) { 

        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.right.get(audioWaveIndex)*ampWave;

        xcurveVertex(pointPaths[i][j].x+audioWave*2, pointPaths[i][j].y, 10);//floor(easeAudio)
        xcurveVertex(pointPaths[i][j].x+audioWave*2, pointPaths[i][j].y, 105);
      } // j
    } // i
    xendShape();




    popMatrix();
  } // if pointsPath
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/