/*---- YOUR CUSTOM CODE BELOW ------------------------*/


/*---- PUT OWN VARIABLES JUST BEFORE customSetup()-----*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void ySetup() { // custom setup = runs once
}

void yDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "Celine.Pereira \nPatricia.Grabowicz"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.75; // <- custom size
  myTextLength = 10; // <- custom length for cuts
  processType(); // <- function below (comment out if you prefer custom)
  background(0); // <- up to you if you want a background!
  //backgroundFade(20); // prefer fade?
  smooth();
  
 

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 
   scale(map(avgAudio,0,maxAudio,.85,1));
 
  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 
    stroke(255); // optional...
    //fill(255);
  
    for (int i = 0; i < pointPaths.length; i++) { 
      pushMatrix();
        //scale(map(avgAudio,0,maxAudio,.65,.75)); // <- custom scale of letters

      for (int k=1; k<30;k++){
        rotateZ(map(k,1,10,0,2*PI)+radians(frameCount*0.1));
        stroke(255);
      beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        


        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.left.get(audioWaveIndex)*ampWave;  
        
        //int loop Points = int map(easeAudio,0,maxAudio,0,pointsPath[i].length));

        //float aSize = map(avgAudio,0,maxAudio,5,50);
        
        vertex(pointPaths[i][j].x, pointPaths[i][j].y,5,5); // try other shapes 
        
        //line(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq,10,10); // try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      } 
      endShape();
      
      
      if(k == 6){
        xstroke(255,0,0);
      xbeginShape();
      
      for (int j=0; j < pointPaths[i].length; j++) { 
        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.left.get(audioWaveIndex)*ampWave;  
       
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
        
      } 
      xendShape();
      }
    } // k
    popMatrix();
    
    
    
          pushMatrix();

    
        popMatrix();

    
    }
    
    
  }



  popMatrix();
  
  
  
  
  
  
  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 
   scale(0.45);
 
  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 
    stroke(255); // optional...
    //fill(255);
  
    for (int i = 0; i < pointPaths.length; i++) { 
      pushMatrix();
        //scale(map(avgAudio,0,maxAudio,.65,.75)); // <- custom scale of letters

      for (int k=1; k<30;k++){
        rotateZ(map(k,1,10,0,2*PI)+radians(frameCount*0.1));
      beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        


        int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
        float audioWave = in.left.get(audioWaveIndex)*ampWave;  
        
        //int loop Points = int map(easeAudio,0,maxAudio,0,pointsPath[i].length));

        //float aSize = map(avgAudio,0,maxAudio,5,50);
        
        vertex(pointPaths[i][j].x, pointPaths[i][j].y,5,5); // try other shapes 
        
        //line(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq,10,10); // try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      } 
      endShape();
    } // k
    popMatrix();
    
    
    
          pushMatrix();

    
        popMatrix();

    
    }
    
    
  }



  popMatrix();
}

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/