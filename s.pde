/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void sSetup() { // custom setup = runs once
background(0);
}

void sDraw() { // custom draw = renders fooorever

//SETTINGS [change, but don't delete any]
  credits = "Livia.Graf & Julien.Rondez"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.75+(easeAudio*100); // <- custom size
  myTextLength = 10*avgAudio; // <- custom length for cuts
  processType(); // <- function below (comment out if you prefer custom)
  //background(0); // <- up to you if you want a background!
  backgroundFade(5); // prefer fade?

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out 
  scale(.9*sin(frameCount*.002)); // <- custom scale of letters

  rotateZ(maxAudio);
  
  

    if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 
    strokeWeight(0.5);
    stroke(255); // optional...
    //fill(50);

    for (int i = 0; i < pointPaths.length; i++) { 
      beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 

        // [i] refers to which character, [j] refers to which point in that character
      } 
      endShape();
      xstroke(30, 243, 220);
      xbeginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 

        // [i] refers to which character, [j] refers to which point in that character
      } 
      xendShape();
      
      
      /* beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        vertex(pointPaths[i][j].x*3, pointPaths[i][j].y); // try other shapes 

        // [i] refers to which character, [j] refers to which point in that character
      } 
      endShape();
      */
    }
  }
  
  
  popMatrix();
}
/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/