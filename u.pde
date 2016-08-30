
float uSize = 0.4;                    // initial size
float uRotationSpeed = 0.2;           // idle rotation speed
float uRotationSens = 0.01;            // audio impact on rotation speed
float uLength = 10;                   // initial leghth of segments    
float uLengthSens = 2;                // audio impact on length of segments ***
float uSizeSens = 0.2;               // audio impact on size
float uLayerRotation = 0.03;          // rotation between repeated layers
int uRep = 1;                        // number of repeated layers
float uAttAudio = 0.8;                 // audio attenuator
float uRotateX;
float uRotateY;
float uRotateZ;
float uAudio;
float ubass; 
float umid; 
float uhigh;

void uSetup() { // custom setup = runs once
  ampWave = 250;
}

void uDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  ubass = fft.calcAvg(40,400)*amp; // fft.calcAvg(minFreq, maxFreq)  
  umid = fft.calcAvg(400,3000)*amp;  
  uhigh = fft.calcAvg(3000,10000)*amp; 
  
  credits = "Sina.Gerschwiler"; // put your name[s] here!
  myTextFont = "FreeSans.ttf";         // alternatively: "Lato-Light.ttf" or "Lato-Bold.ttf" or "FreeSans.ttf"
  myTextSize = height*.75; // <- custom size
  useLowerCase = true; // *NEW* optionally set true for lowercase
  myTextLength = 15;//uLength + easeAudio * uLengthSens; // <- custom length for cuts
  
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  
  
  uAudio = easeAudio*2 * uAttAudio;
  
 // gRotateX = (gRotationSpeed / 100 + gRotationSens * gAudio / 1000) * millis() * PI/40;
  uRotateY = (uRotationSpeed / 10 + uRotationSens * uAudio / 10000) * millis() * PI/40;
  uRotateZ = (uRotationSpeed / 1000 + uRotationSens * uAudio / 10000) * millis() * PI/40;

  translate(width/2, height/2, 200); // suggestion to draw from center out
  scale(uSize + (uAudio * uSizeSens /20)); // <- custom scale of letters
 println(uSize + (uAudio * uSizeSens /20));
  //rotateX(gRotateX);
  rotateY(uRotateY);
  rotateZ(uRotateZ);
  strokeWeight(2);

  if (pointPaths != null) { // draw if points ready
  
  
      for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      //xstroke (255, 255, 255);                           //         !!!   LASER BRIGHTNESS (COLOR ?)

        // rotateX(gLayerRotation);
        // rotateY(gLayerRotation);
        // rotateZ(gLayerRotation);
        
      xbeginShape();                                     //         !!!   FOR LASER OUTPUT
      for (int j=0; j < pointPaths[i].length; j++) { 
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y); //         !!!   FOR LASER OUTPUT
      } // j
      xendShape();                                       //         !!!   FOR LASER OUTPUT
    } // i
  
  }
  
  
  
  myTextLength = uLength + easeAudio * uLengthSens; // <- custom length for cuts
  processType(); // takes care of type for you, turn off if using custom
  
  
  if (pointPaths != null) { // draw if points ready

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      int uStroke = 255;
      
      for (int ij = 0; ij < uRep; ij++) {
        stroke (uStroke);                                 //       !!!   FOR LASER OUTPUT: xstroke
      

        rotateX(uLayerRotation);
        rotateY(uLayerRotation);
        //rotateZ(uLayerRotation);
        
      beginShape();                                     //         !!!   FOR LASER OUTPUT: xbeginShape
      for (int j=0; j < pointPaths[i].length; j++) {
         stroke(255);
        int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 10, fft.avgSize()));  
        float audioFreq = fft.getAvg(audioFreqIndex)*amp*2;
        point(pointPaths[i][j].x, pointPaths[i][j].y,10);
        stroke(255);
        strokeWeight(10);
        point(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq, uhigh); 
        stroke(255);
        strokeWeight(10);
        point(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq, umid);  
        stroke(255); 
        strokeWeight(5);
        point(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq, ubass); // try other shapes 
        
        if(j%5==0){
        xbeginShape();
        xvertex(pointPaths[i][j].x+audioFreq*3, pointPaths[i][j].y+audioFreq*3, ubass*3); // try other shapes 
        xvertex(pointPaths[i][j].x+audioFreq*3+3, pointPaths[i][j].y+audioFreq*3, ubass*3); // try other shapes 

        xendShape();
        }
      }
      
      endShape();                                       //         !!!   FOR LASER OUTPUT: xendShape
      } // ij
    } // i
    
  }  // if pointPath

}  // draw




/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/