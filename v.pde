/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void vSetup() { // custom setup = runs once
}

void vDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "sina.grass"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*5; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  // translate(width/2, height/2); // suggestion to draw from center out 

  for (int k = 0; k < 100; k++) {


    pushMatrix(); // only adjusts translate/scale within matrix

    println(easeAudio);
    float zPos = map(easeAudio, maxAudio*2, 0, 0, 2+k); 



    translate(width/2, height/2, -height*zPos/2+10*easeAudio); // suggestion to draw from center out 

    rotate(easeAudio*k/150);
    scale(0.5+easeAudio/15);


    if (pointPaths != null) { // only draw if points ready 
      noFill(); // optional.. 
      //fill(0, 255);

      stroke(255); // optional...

      for (int i = 0; i < pointPaths.length; i++) { 
        beginShape(); 
        for (int j=0; j < pointPaths[i].length; j++) { 

          int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
          float audioWave = in.left.get(audioWaveIndex)*ampWave;

          //scale(1+audioWave/1000);
          strokeWeight(audioWave/2);
          //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 5, 5); // try other shapes 

          vertex(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave); // try other shapes 

          // [i] refers to which character, [j] refers to which point in that character
        } 
        endShape();
      }
    }

    popMatrix();
  }



  for (int k = 0; k < 100; k++) {

    if (k%25 == 0 && k > 10) {
      pushMatrix(); // only adjusts translate/scale within matrix

      println(easeAudio);
      float zPos = map(easeAudio, maxAudio*2, 0, 0, 2+k); 

      translate(width/2, height/2, -height*zPos/2+20*easeAudio); // suggestion to draw from center out 

      rotate(easeAudio*k/150);
      scale(easeAudio/15);

      if (pointPaths != null) { // only draw if points ready 
        noFill(); // optional.. 
        //fill(255, 40);

        // xstroke(255, 0, 0); // optional...

        for (int i = 0; i < pointPaths.length; i++) {

         xstroke(255, 255, 0);
          xbeginShape(); 
          for (int j=0; j < pointPaths[i].length; j++) { 

            //int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
            //float audioWave = in.left.get(audioWaveIndex)*ampWave;

            //scale(1+audioWave/1000);
            // strokeWeight(audioWave/2);
            //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 5, 5); // try other shapes 

            if (j%5 == 0) {
              //strokeWeight(easeAudio/10);
              xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
              //ellipse(pointPaths[i][j].x, pointPaths[i][j].y, 5*audioWave/5, 5); // try other shapes
            }

            // [i] refers to which character, [j] refers to which point in that character
          } 
          xendShape();
        }
      }

      popMatrix();
    } // if pointsPath
  }
}


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/