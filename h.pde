
/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

float hbass; 
float hmid; 
float hhigh; 
void hSetup() { // custom setup = runs once
}

void hDraw() { // custom draw = renders fooorever

  hbass = fft.calcAvg(20, 400)*amp; // fft.calcAvg(minFreq, maxFreq)  
  hmid = fft.calcAvg(400, 3000)*amp;  
  hhigh = fft.calcAvg(3000, 10000)*amp;

  //SETTINGS [change, but don't delete any]
  credits = "silvio.meessen"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.6; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 25; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 

  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 

    for (int i = 0; i < pointPaths.length; i++) { 
      noFill();
      stroke(255); // optional...

      pushMatrix();
      noStroke();
      fill(random(150));
      for (int j=0; j < pointPaths[i].length; j++) { 

        if (j%3==1+1) {
          hbass = fft.calcAvg(20, 60)*amp/3;
          //println(hbass);
          int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));
          float audioWave = in.left.get(audioWaveIndex)*ampWave;

          if (hbass > 40) {
            strokeWeight(1);
            xstroke(150, 0, 0);
            xrectMode(CENTER);
            xrect(pointPaths[i][j].x, pointPaths[i][j].y, hbass/2, hbass/2); // try other shapes
            // [i] refers to which character, [j] refers to which point in that character 
            // rotateX(radians(frameCount/10));
            //println(avgAudio);
            fill(255, 0, 0);
            noStroke();
          }
        }
      } 
      popMatrix();

      pushMatrix(); 
      for (int j=0; j < pointPaths[i].length; j++) { 


        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));
        float audioWave = in.left.get(audioWaveIndex)*ampWave;

        rotateX(radians(frameCount*avgAudio/10));
        println(avgAudio);
        fill(255/audioWave);
        noStroke();

        rect(pointPaths[i][j].x, pointPaths[i][j].y, avgAudio, avgAudio); // try other shapes
        // [i] refers to which character, [j] refers to which point in that character
      } 
      popMatrix(); 


      pushMatrix();

      hbass = fft.calcAvg(20, 200)*amp; // fft.calcAvg(minFreq, maxFreq)  
      hmid = fft.calcAvg(400, 3000)*amp;  
      hhigh = fft.calcAvg(3000, 10000)*amp;

      /*
      for (int j=0; j < pointPaths[i].length; j++) { 
       
       
       int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));
       float audioWave = in.left.get(audioWaveIndex)*ampWave;
       
       
       // [i] refers to which character, [j] refers to which point in that character 
       rotateX(radians(frameCount/bass+maxAudio));
       println(avgAudio);
       //fill(255/audioWave);
       fill(0);
       noStroke();
       ellipse(pointPaths[i][j].x, pointPaths[i][j].y, 10, 10/high+audioWave); // try other shapes
       }*/
      popMatrix();

      for (int j=0; j < pointPaths[i].length; j++) {
      }
    }
  }


  popMatrix();
}

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/