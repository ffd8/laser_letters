/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void eSetup() { // custom setup = runs once
}

void eDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "lena.meier"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2, -height/2); // suggestion to draw from center out 

  pushMatrix();
  rotateY(radians(map(sin(frameCount*.1),-1,1,-10,10)));
  rotateZ(radians(frameCount));
  //rotate(radians(frameCount));

  for (int k=0; k< 25; k++) { // loop


    pushMatrix();
    translate(0, 0, k*4*easeAudio);
    if (pointPaths != null) { // only draw if points ready 
      //noFill();
      fill(255, 50); // optional.. 
      stroke(255); // optional...
      //translate(0, 0, 100*k);
      //rotateX(radians((-k+1)*100));  
      //rotateY(radians((-k+1)*50));
      rotateZ(radians((-k+1)*10));

      for (int i = 0; i < pointPaths.length; i++) { 
     
        beginShape(); 



        /*translate(0, 0, 50);
         rotateX(radians(-k+1*0.5*frameCount));  
         rotateY(radians(-k+1*0.5*frameCount));
         rotateZ(radians(-k+1*0.5*frameCount));*/




        //scale(1); // changes scale of shape drawn  

        for (int j=0; j < pointPaths[i].length; j++) {
          int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
          float audioWave = in.left.get(audioWaveIndex)*ampWave;
          //float audioWave = in.right.get(audioWaveIndex)*ampWave;
          vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
          // [i] refers to which character, [j] refers to which point in that character

          /*if (k%10 == 0) {
           xstroke(255, 0, 0);
           noFill();
           xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
           } else {
           fill(255, 20);
           vertex(pointPaths[i][j].x, pointPaths[i][j].y);
           }*/

          if (k%70 == 0) {
          } else {
            vertex(pointPaths[i][j].x, pointPaths[i][j].y);
          }
        } 


        endShape(CLOSE);




        xbeginShape(); 



        /*translate(0, 0, 50);
         rotateX(radians(-k+1*0.5*frameCount));  
         rotateY(radians(-k+1*0.5*frameCount));
         rotateZ(radians(-k+1*0.5*frameCount));*/




        //scale(1); // changes scale of shape drawn  

        for (int j=0; j < pointPaths[i].length; j++) {
          int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
          float audioWave = in.left.get(audioWaveIndex)*ampWave;
          //float audioWave = in.right.get(audioWaveIndex)*ampWave;
          //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
          // [i] refers to which character, [j] refers to which point in that character

          /*if (k%10 == 0) {
           xstroke(255, 0, 0);
           noFill();
           xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
           } else {
           fill(255, 20);
           vertex(pointPaths[i][j].x, pointPaths[i][j].y);
           }*/

          if (k%70 == 0) {
            noFill();
            xstroke(0, 0, 255);
            xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
          } else {
            //vertex(pointPaths[i][j].x, pointPaths[i][j].y);
          }
        } 


        xendShape();
      }
    }
    popMatrix();
  }

  popMatrix();
  popMatrix();
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/