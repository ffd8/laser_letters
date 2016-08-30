/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void mSetup() { // custom setup = runs once
  //myText = "m";
}

void mDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "Anja.Furrer + Lisa.Hartmann"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.65; // *NEW* set text size (0 - height)
  //useLowerCase = true; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


 pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2, -height/2+avgAudio*30); // suggestion to draw from center out
  rotateY(map(frameCount*5, 0, width, -PI, PI));
  //rotateX(map(frameCount*1.5, 0, width, -PI, PI));
  // scale(.65);
  //translate(width/2, height/2); // suggestion to draw from center out 
  //println(frameCount);
  
  if (pointPaths != null) { // draw if points ready 
    fill (255);
    stroke(255); 

   for (int i = 0; i < pointPaths.length; i++) {
      //noFill();
      //stroke(255);

      //beginShape(); // just demo shape below!
      
    for (int j=0; j < pointPaths[i].length; j++) { 
  
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.left.get(audioWaveIndex)*ampWave; 
            
            if (audioWave > 5 && j%5==0) { 
              
            noFill();
         
            xstroke(255,0,0); //  sets laser to red 
            
            float mSize = map(avgAudio, 0, maxAudio, 80, 1);
            xrect(pointPaths[i][j].x, pointPaths[i][j].y,mSize, 6);
            
            noStroke();
            
            //xellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 70, 70);
            //xpoint(width/2, height/2); // draws single point 
            
            }else {
              
            fill (255);
            
            float mSize = map(avgAudio, 0, maxAudio, 80, 1);
            rect(pointPaths[i][j].x, pointPaths[i][j].y,mSize, 6);
            
            //ellipse(pointPaths[i][j].x, pointPaths[i][j].y,4, 4);
            //noFill();
            //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave,4, 4);
            
            
            
              
            
            } 
            //audio wird laut --> M zersplittert
            
            
            //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
            // [i] refers to which character, [j] refers to which point in that character
            //line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, mouseX-width*.5, mouseY-height*.5);
            //ellipse(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 10, 10);
            //xrect(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 10, 10);
            //line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave, 30, 30);
        } 
      //endShape();
      
    } // i
    
  } // if pointsPath
  popMatrix();
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/