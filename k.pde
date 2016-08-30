
/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void kSetup() { // custom setup = runs once
}

void kDraw() { // custom draw = renders fooorever

  translate(width/2, height/2, -height/2);
  rotateY(radians(frameCount*1));

  //SETTINGS [change, but don't delete any]
  credits = "lara.schai"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.8; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D

  for (int k=1; k < 10; k++) { 


    pushMatrix(); // only adjusts translate/scale within matrix
    if (maxAudio > 5) {
      strokeWeight(5);
      //scale(avgAudio/40);


      if (pointPaths != null) { // only draw if points ready 
        noFill(); // optional.. 

        for (int i = 0; i < pointPaths.length; i++) { 

          noFill();
          stroke(255); // optional...
          //fill(30); // optional...
          beginShape(); 


          for (int j=0; j < pointPaths[i].length; j++) { 

            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
            float audioWave = in.left.get(audioWaveIndex)*ampWave*4; 
            float easing = 20; // 0 = never updates, 1 = no smoothing, inbetween = shades of smooth 
            //if(j < pointPaths [i] length/2) {
            /*
        //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
             ellipse(pointPaths[i][j].x, pointPaths[i][j].y,10, 10); // try other shapes 
             // [i] refers to which character, [j] refers to which point in that character
             }
             */


            //if(j%3==2){
            //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
            //line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y,avgAudio, 10); // try other shapes

            //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave,100, 100); // try other shapes 
            curveVertex(pointPaths[i][j].x+audioWave, pointPaths[i][j].y, sin(1));
            //curveVertex(pointPaths[i][j].x+audioWave, pointPaths[i][j].y, 20);
            //curveVertex(easeAudio, easeAudio,40);



            // [i] refers to which character, [j] refers to which point in that character
            strokeWeight(1);

            // }
          } 
          endShape(CLOSE);


        if(k == 1){
          xstroke(100, random(100, 255), random(55, 150));

          xbeginShape(); 


          for (int j=0; j < pointPaths[i].length; j++) { 

            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
            float audioWave = in.left.get(audioWaveIndex)*ampWave; 
            float easing = 20; // 0 = never updates, 1 = no smoothing, inbetween = shades of smooth 

            xvertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
            //scale(2);
            //fill(255);  

            //line(pointPaths[i][j].x, pointPaths[i][j].y,avgAudio, avgAudio); // try other shapes 








            // [i] refers to which character, [j] refers to which point in that character
            //strokeWeight(1);

            // }
          } 
          xendShape();
        }
          beginShape(); 


          for (int j=0; j < pointPaths[i].length; j++) { 

            //translate(width/2, height/2, 100);
            rotateY(radians(frameCount*6));

            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
            float audioWave = in.left.get(audioWaveIndex)*ampWave; 
            float easing = 100; // 0 = never updates, 1 = no smoothing, inbetween = shades of smooth 


            stroke(100);


            ellipse(pointPaths[i][j].x+(map(easeAudio, 0, maxAudio, 0, 100)+audioWave), pointPaths[i][j].y+(map(easeAudio, 0, maxAudio, 0, 100)+audioWave), 3, 3);



            strokeWeight(1);

            // }
          } 
          endShape(CLOSE);
        }
      }
    } else {
      strokeWeight(5);
      fill(255);
    }
    popMatrix();
  }
}









/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/