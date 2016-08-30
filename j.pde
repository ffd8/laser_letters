/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0;

int jloops=10;

void jSetup() { // custom setup = runs once
}

void jDraw() { // custom draw = renders fooorever
useLowerCase = true;

  //SETTINGS [change, but don't delete any]
  credits = "livia.graf"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height; // *NEW* set text size (0 - height)
  useLowerCase = true; // *NEW* optionally set true for lowercase
  myTextLength = 25; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D

  pushMatrix();
  translate(width/2, height/2, -height/2); // suggestion to draw from center out
  rotateY(frameCount*.05);


  if (pointPaths != null) { // draw if points ready
    noFill();

    for (int i = 0; i < pointPaths.length; i++) {

      translate(0, 0, map(i, 0, height, -500, -500));
      //noFill();
      fill(0);
      stroke(255);
      rotateX(frameCount*.05);
      rotateZ(frameCount*.05);

      for (int a=1; a < easeAudio*.15; a++) {
        beginShape(); // just demo shape below!

        for (int j=0; j < pointPaths[i].length; j++) {
          vertex(pointPaths[i][j].x, pointPaths[i][j].y-a*50, a*50);
        } // j
        endShape();
      } // i
    } // if pointsPath
  }

  if (pointPaths != null) { // draw if points ready
    noFill();

    for (int i = 0; i < pointPaths.length; i++) {

      translate(0, 0, map(i, 0, height, -500, -500));
      //noFill();
      fill(0);
      stroke(255);
      rotateX(frameCount*.05);
      rotateZ(frameCount*.05);

      for (int a=1; a < easeAudio*.15; a++) {
        beginShape(); // just demo shape below!

        for (int j=0; j < pointPaths[i].length; j++) {
          vertex(pointPaths[i][j].x, pointPaths[i][j].y-a*50, a*50);
        } // j
        endShape();
      } // i
    } // if pointsPath
  }
  popMatrix();

  //LASER START//


  pushMatrix();  
  if (pointPaths != null) { // draw if points ready


    for (int i = 0; i < pointPaths.length; i++) {

      noFill();
      xstroke(250,205,0);
      translate(width/2, height/2, -height/2); // suggestion to draw from center out
      rotateY(frameCount*.05);
      xbeginShape(); // just demo shape below!

      for (int j=0; j < pointPaths[i].length; j++) {
        xvertex(pointPaths[i][j].x, pointPaths[i][j].y);
      } // j
      xendShape();
    } // if pointsPath
  }

  popMatrix();

  //LASER END//
}  // draw



/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/