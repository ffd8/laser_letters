/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void iSetup() { // custom setup = runs once
}

void iDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "anja.furrer + lisa.hartmann"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.25; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 35; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D
  grp = RG.getText(myText.toUpperCase(), myTextFont, floor(myTextSize), CENTER); 
  grp = RG.centerIn(grp, g);
  RG.setPolygonizer(RG.ADAPTATIVE);
  pointPaths = grp.getPointsInPaths();

  pushMatrix();
  translate(width/2, height/2, -height/2+avgAudio*10);
  rotateY(map(frameCount*1.5, 0, width, -PI, PI));
  scale(.65); // <- custom scale of letters

  if (pointPaths != null) { // draw if points ready 
    //fill(255); // optional.. 
    noFill();
    stroke(255); // optional...
    grp.draw();
    pushMatrix();
    translate(0, 0, 100);
    grp.draw();
    popMatrix();

    for (int i = 0; i < pointPaths.length; i++) { 
      beginShape();
      
      for (int j=0; j < pointPaths[i].length; j++) { 

        int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, fft.avgSize()));  
        float audioFreq = fft.getAvg(audioFreqIndex)*amp;
        stroke(255);
        noFill();        
        line(pointPaths[i][j].x, pointPaths[i][j].y, 0, pointPaths[i][j].x, pointPaths[i][j].y, 100);
       
        
        ////
        pushMatrix();
        translate(0, audioFreq*15, 0);
        //translate(0, 0, audioFreq*15);
        noFill();
        stroke(255);
        //box(100, 700, 100);
        ////
        
        line(pointPaths[i][j].x, pointPaths[i][j].y, 0, pointPaths[i][j].x, pointPaths[i][j].y, 100);
        xrect(pointPaths[i][j].x, pointPaths[i][j].y, 15, 15);
        
        float aSize = map(avgAudio, 0, maxAudio, 5, 50);
        
        noFill();
        //xrect(pointPaths[i][j].x, pointPaths[i][j].y, audioFreq*30, audioFreq*30);
        xellipse(pointPaths[i][j].x, pointPaths[i][j].y, audioFreq, audioFreq);
        //xrect(pointPaths[i][j].x, pointPaths[i][j].y, 15, 15);

        fill(255);
        rect(pointPaths[i][j].x, pointPaths[i][j].y, audioFreq*4, audioFreq*4);
        //rect(pointPaths[i][j].x, pointPaths[i][j].y, audioFreq*30, audioFreq*30);
        
        popMatrix();
        
        

        //xvertex(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y); // try other shapes 
        // [i] refers to which character, [j] refers to which point in that character
      }
    
      //endShape();
      
    } // i
    
  } // if pointsPath
  popMatrix();
  
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/