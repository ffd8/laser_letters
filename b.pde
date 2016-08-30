/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void bSetup() { // custom setup = runs once
}

void bDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "ted.davis"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.6; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  
  translate(width*.5, height*.5); // suggestion to draw from center out 
  noFill();
  if (pointPaths != null) { // draw if points ready 
    pushMatrix();
    popMatrix();
    rotateZ(radians(frameCount*.4));

      if(sin(frameCount*.01) < .5){
      xstroke(150, 150, 0);
      for (int i = 0; i < pointPaths.length; i++) {
        pushMatrix();
        translate(0, 0, map(sin(frameCount*.01), -1, 1, -height*.5, height));
        xbeginShape(); // just demo shape below!
        for (int j=0; j < pointPaths[i].length; j++) {
           xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
        }
        xendShape();
        popMatrix();
      }
      }
    int audioLoop = floor(map(avgAudio, 0, 50, 1, 360));

    for (int k=0; k < audioLoop; k+=2) {
      for (int i = 0; i < pointPaths.length; i++) {
        pushMatrix();
        translate(0, 0, map(sin(frameCount*.01), -1, 1, -height*.5, height));
        scale(map(k, 0, 360, 1, 0));
        rotateZ(radians(map(k, 0, 360, 0, 180)));
        noFill();
        stroke(map(k, 0, audioLoop, 255, 0));
        beginShape(); // just demo shape below!
        
        for (int j=0; j < pointPaths[i].length; j++) { 
          int audioWaveIndex = floor(map(j*k, 0, pointPaths[i].length*k, 0, in.bufferSize()));  
          float audioWave = in.left.get(audioWaveIndex)*ampWave/2;
          int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, fft.avgSize()));  
          float audioFreq = fft.getAvg(audioFreqIndex)*amp;  
          vertex(pointPaths[i][j].x, pointPaths[i][j].y, -audioFreq*k*.2);
        } // j
        endShape();
        
        if(sin(frameCount*.01) > .7 && k > audioLoop-2){
          xstroke(150, 150, 0);
          xbeginShape();
            int rsel = frameCount%(pointPaths[i].length-6);//floor(random(pointPaths[i].length-4));
            xvertex(pointPaths[i][rsel].x, pointPaths[i][rsel].y, -k*.2);
            xvertex(pointPaths[i][rsel+1].x, pointPaths[i][rsel+1].y, -k*.2);
            xvertex(pointPaths[i][rsel+2].x, pointPaths[i][rsel+2].y, -k*.2);
            xvertex(pointPaths[i][rsel+3].x, pointPaths[i][rsel+3].y, -k*.2);
            xvertex(pointPaths[i][rsel+4].x, pointPaths[i][rsel+4].y, -k*.2);
          xendShape();
        }

        popMatrix();
      } // k
    } // i
  } // if pointsPath
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/