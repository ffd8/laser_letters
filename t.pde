/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

float ta = 3;
float tb = 3;
float tc = 0.1;

float tbass; 
float tmid; 
float thigh; 

void tSetup() { // custom setup = runs once
  RG.setPolygonizerLength(avgAudio); // use average audio for shape segmenting
}


void tDraw() { // custom draw = renders fooorever

  tbass = fft.calcAvg(20, 400)*amp; // fft.calcAvg(minFreq, maxFreq)  
  tmid = fft.calcAvg(400, 3000)*amp;  
  thigh = fft.calcAvg(7000, 10000)*amp; 
  //println(thigh);

  //SETTINGS [change, but don't delete any]
  credits = "linda.walter"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.8; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D



  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 
  scale(.65); // <- custom scale of letters

  if (pointPaths != null) { // draw if points ready 

    for (int i = 0; i < pointPaths.length; i++) {
      noFill();
      stroke(255);

      beginShape(); // just demo shape below!
      for (int j=0; j < pointPaths[i].length; j++) { 

        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 

       // int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, fft.avgSize()));  
        //float audioFreq = fft.getAvg(audioFreqIndex)*amp;

       if (int(audioWave)%pointPaths[i].length==0) {
         //if (j%2==0){
          //frameCount (5);
          noFill();
          xstroke(map(abs(thigh),0,1,50,100), 0, 0);
          xline(pointPaths[i][j].x-10, pointPaths[i][j].y-10, pointPaths[i][j].x-10+tb, pointPaths[i][j].y-10+tbass);
        } 
       
        
        /*if (j%20==10) { 
          //fill(100, 100);
          stroke(100, 100);
          //rect((pointPaths[i][j].x)* map(avgAudio, 0, maxAudio, 1.3, 1.7), pointPaths[i][j].y, audioWave*c/100, tbass*5);
          line((pointPaths[i][j].x), pointPaths[i][j].y, c, c);
        } 
*/
        if (j%6==0) { 
          fill(255);
          rectMode(CENTER);
          noStroke();
          rect((pointPaths[i][j].x)* map(avgAudio, 0, maxAudio, 1.3, 1.7), pointPaths[i][j].y, tbass/6, tbass/6);
        }
        
         /*if (j%5==0) { 
          noFill();
          //rectMode(CENTER);
          stroke(255);
          xellipse((pointPaths[i][j].x)* map(avgAudio, 0, maxAudio, 1.3, 1.7), pointPaths[i][j].y, tbass/6, tbass/6);
        }
        */

        if (j%8==0) { 
          fill(255, 255, 255, (map(pointPaths[i][j].y, 100, 10, 50, 200))*0.001*ta/3);
          noStroke();
          rect((pointPaths[i][j].x)* map(avgAudio, 0, maxAudio, 1.3, 1.7), pointPaths[i][j].y, tmid*2, tmid*2);
        } else {
          pushMatrix();
          noStroke();
          fill(255, 255, 255, (map(pointPaths[i][j].y, 50, 250, 50, 200))*0.1*ta/3);
          rect((pointPaths[i][j].x)* map(avgAudio, 0, maxAudio, 1.3, 1.7), pointPaths[i][j].y, 1, tb/5); // try other shapes
          popMatrix();
        }
        println (audioWave);

        ta += 0.04;
        tb += 0.01;
        tc *= map(0, 0, maxAudio, 1, 1.1);
        //println(tc);

        fill(random(250), 100); 
        noStroke();

        //println(a);
        if (ta >= 150) {
          ta*=-1;
        }

        //println(b);
        if (tb >= 70) {
          tb*=-1;
        }

        if (tc == 1 ) {
          tb*=-1;
        }
      } // j
      endShape();
    } // i
  } // if pointsPath
  popMatrix();
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/