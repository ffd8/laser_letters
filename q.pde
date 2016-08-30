
/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void qSetup() { // custom setup = runs once
  myText = "q";
}

void qDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "Johanna.Bühler \nSonya.Haksar"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  translate(width/2, height/2); // suggestion to draw from center out 

  if (pointPaths != null) { // draw if points ready 
    noFill();
    stroke(255);
    myTextSize = height*.3; // *NEW* set text size (0 - height)


    for (int i = 0; i < pointPaths.length; i++) { 
      beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        pushMatrix();
        strokeWeight(.5);
        ellipse(pointPaths[i][j].x, pointPaths[i][j].y,avgAudio*5, avgAudio*8);
        popMatrix();
      } 
      endShape();
    } // i




 // second letter - rotation
    pushMatrix();
    myTextSize = height*.6; // *NEW* set text size (0 - height)
    rotateY(radians(frameCount*.3));
      
    for (int i = 0; i < pointPaths.length; i++) { 
      if(i%2==0){
        xstroke(255,0,0);
      }else{
        xstroke(255*.7,255*.95,255*.35);
      }
      xbeginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        strokeWeight(3);
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y, 10);
      } 
      xendShape();
    } //k
  } // if pointsPath


  popMatrix();
}  // draw


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/