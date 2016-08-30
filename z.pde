
void zSetup() { // custom setup = runs once
}

void zDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "ted.davis"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.6; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 20; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  translate(width/2, height/2); // suggestion to draw from center out 

  strokeWeight(1);
  if (pointPaths != null) { // draw if points ready 

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      stroke(255);
      noFill();
      stroke(255);
      rotateY(radians(frameCount*.74));
      strokeWeight(map(easeAudio,0,50,.1,1));
      beginShape(); // just demo shape below!
      for (int j=0; j < pointPaths[i].length; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWaveL = in.left.get(audioWaveIndex)*ampWave*.5; 
        float audioWaveR = in.right.get(audioWaveIndex)*ampWave*.5; 

        int selShift = int(easeAudio*.3+j)%pointPaths[i].length;
        vertex(pointPaths[i][j].x+audioWaveL, pointPaths[i][j].y+audioWaveL, -200); 
        float zoff = map(sin(frameCount*.01), -1, 1, -100-easeAudio, 100+easeAudio);
        vertex(pointPaths[i][selShift].x, pointPaths[i][selShift].y, 0);
        //vertex(pointPaths[i][j].x+audioWaveR, pointPaths[i][j].y+audioWaveR, 200);
      } // j
      endShape();

      //LASER
      int mLoop = floor(map(easeAudio, 0, maxAudio, 0, pointPaths[i].length));
      xstroke(map(mLoop,0,pointPaths[i].length,50,255), map(mLoop,0,pointPaths[i].length,255,50), 0);
      xbeginShape(); // just demo shape below!
      for (int j=0; j < mLoop; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWaveL = in.left.get(audioWaveIndex)*ampWave*.5; 
        float audioWaveR = in.right.get(audioWaveIndex)*ampWave*.5; 
        xvertex(pointPaths[i][j].x+audioWaveL, pointPaths[i][j].y, -200);
      } // j
      xendShape();

      //LASER
      
      mLoop = floor(map(easeAudio, 0, maxAudio, pointPaths[i].length,0));
      xstroke(0,map(mLoop,pointPaths[i].length,0,255,50),map(mLoop,pointPaths[i].length,0,50,255));
      xbeginShape(); // just demo shape below!
      for (int j=0; j < mLoop; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWaveL = in.left.get(audioWaveIndex)*ampWave*.5; 
        float audioWaveR = in.right.get(audioWaveIndex)*ampWave*.5; 
        xvertex(pointPaths[i][j].x-audioWaveR, pointPaths[i][j].y, 0);
      } // j
      xendShape();
       
    } // i
  } // if pointsPath
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/