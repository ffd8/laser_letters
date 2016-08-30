
/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!

float gSize = 0.3;                    // initial size
float gRotationSpeed = 0.8;           // idle rotation speed
float gRotationSens = 0.05;            // audio impact on rotation speed
float gLength = 50;                   // initial leghth of segments    
float gLengthSens = 2;                // audio impact on length of segments ***
float gSizeSens = 0.2;               // audio impact on size
float gLayerRotation = 0.03;          // rotation between repeated layers
int gRep = 30;                        // number of repeated layers
int gDim = 5;                        // fade between repeated layers
float gAttAudio = 0.5;                 // audio attenuator

float gRotateX;
float gRotateY;
float gAudio;

void gSetup() { // custom setup = runs once
  ampWave = 250;
}

void gDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  
  credits = "Salomé.Neuhaus"; // put your name[s] here!
  myTextFont = "FreeSans.ttf";         // alternatively: "Lato-Light.ttf" or "Lato-Bold.ttf" or "FreeSans.ttf"
  myTextSize = height*.75; // <- custom size
  // useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = gLength + easeAudio * gLengthSens; // <- custom length for cuts
  
  processType(); // takes care of type for you, turn off if using custom
  // background(0); // default background
  backgroundFade(10); // very experimental.. sorta fails in 3D
  
  gAudio = easeAudio * gAttAudio;
  
  gRotateX = (gRotationSpeed / 100 + gRotationSens * gAudio / 1000) * millis() * PI/40;
  gRotateY = (gRotationSpeed / 100 + gRotationSens * gAudio / 1000) * millis() * PI/30;

  translate(width/2, height/2, 200); // suggestion to draw from center out
  scale(gSize + (gAudio * gSizeSens / 10)); // <- custom scale of letters
  rotateX(gRotateX);
  rotateY(gRotateY);
  strokeWeight(1);

  if (pointPaths != null) { // draw if points ready
  
  
      for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      xstroke (255, 255, 255);                           //         !!!   LASER BRIGHTNESS (COLOR ?)

        // rotateX(gLayerRotation);
        // rotateY(gLayerRotation);
        // rotateZ(gLayerRotation);
        
      xbeginShape();                                     //         !!!   FOR LASER OUTPUT
      for (int j=0; j < pointPaths[i].length; j++) { 
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y); //         !!!   FOR LASER OUTPUT
      } // j
      xendShape();                                       //         !!!   FOR LASER OUTPUT
    } // i
  
  

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      int gStroke = 255;
      
      for (int ij = 0; ij < gRep; ij++) {
        stroke (gStroke);                                 //       !!!   FOR LASER OUTPUT: xstroke
        gStroke = gStroke - gDim;

        rotateX(gLayerRotation);
        rotateY(gLayerRotation);
        rotateZ(gLayerRotation);
        
      beginShape();                                     //         !!!   FOR LASER OUTPUT: xbeginShape
      for (int j=0; j < pointPaths[i].length; j++) { 
        vertex(pointPaths[i][j].x, pointPaths[i][j].y); //         !!!   FOR LASER OUTPUT: xvertex
        // curveVertex(pointPaths[i][j].x, pointPaths[i][j].y); // !!!  (FOR LASER OUTPUT: xcurveVertex)
      } // j
      endShape();                                       //         !!!   FOR LASER OUTPUT: xendShape
      } // ij
    } // i
    
  }  // if pointPath

}  // draw




/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/