

/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void lSetup() { // custom setup = runs once
}

void lDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "sarah.schiltknecht"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.8; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2, -height/2); // suggestion to draw from center out 

  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 
    if (avgAudio<maxAudio/4) {
      translate(0, 0, -height*3);
    }
      rotate(radians(frameCount*0.09));


    for (int i = 0; i < pointPaths.length; i++) { 
      pushMatrix();
      noFill();
      stroke(255); // optional...

      //fill(255); // optional...
      xbeginShape(); 

      for (int j=0; j < pointPaths[i].length; j++) { 


        int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, fft.avgSize()));  
        float audioFreq = fft.getAvg(audioFreqIndex)*amp;  


        if (audioFreq > 10) {
          xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
        }// try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      } 
      xendShape();

      popMatrix();


      /*pushMatrix();
       beginShape();
       stroke(255, 80, 120);
       for (int j=0; j < pointPaths[i].length; j++) { 
       
       
       int audioWave_x = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
       float audioWave = in.left.get(j)*amp; 
       vertex(audioWave_x, height*.25 + audioWave);  
       //if ( > 10) {
       pushMatrix();
       rotate(radians(frameCount*0.5));
       
       //ellipse(pointPaths[i][j].x, pointPaths[i][j].y,audioFreq,audioFreq);
       
       line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, audioWave, audioWave);
       popMatrix();
       //}
       }
       
       endShape();
       popMatrix();*/

      stroke(255);
      for (int j=0; j < pointPaths[i].length; j++) { 


        int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, fft.avgSize()));  
        float audioFreq = fft.getAvg(audioFreqIndex)*amp;  

        if (audioFreq > 10) {
          pushMatrix();
          //translate(width/3, height/10, map(100, 0, height, -100, 100));
          //rotateY(radians(frameCount*.09)); // (mouseX) moves

          //ellipse(pointPaths[i][j].x, pointPaths[i][j].y,audioFreq,audioFreq);

          rect(pointPaths[i][j].x, pointPaths[i][j].y, 62, audioFreq);
          popMatrix();
        } else if (audioFreq < 20) {
          fill(255);
          pushMatrix();
          stroke(255);

          translate(width/7, height/17, map(100, 0, height, -100, 100));
          vertex(pointPaths[i][j].x, pointPaths[i][j].y, 100, 100);
          popMatrix();
        }// try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      }
    }
  }


  popMatrix();
}

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/