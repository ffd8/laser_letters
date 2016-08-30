/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 

void dSetup() { // custom setup = runs once
}

void dDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "sonya.haksar, johanna.buehler"; // put your name[s] here!
  myTextFont = "Arial Black.ttf"; // set font
  myTextSize = height*20; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 20; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


  //translate(width/2, height/2); // suggestion to draw from center out 

  if (pointPaths != null) { // draw if points ready 

    for (int k=0; k < 50; k+=3) { 

      pushMatrix(); //isolates objects for transformations
      translate(width/2, height/2, map(0, 0, height, -500, 500)); //moves the 0,0 coordinate (left corner) to the center
      rotateX(k);

      //rotateY(k);
      //rotateZ(k);

      //rotateX(radians(k));
      //rotateY(radians(k));
      //rotateZ(radians(k));

      //rotateX(radians(k*frameCount*.10));

      for (int i = 0; i < pointPaths.length; i++) { 

        for (int j=0; j < pointPaths[i].length; j++) { 
          pushMatrix();

          float zAxis = map(easeAudio, 0, maxAudio, -10, 10);
          float dsize = map(easeAudio, 0, maxAudio, -2, -2);

          translate(0, 0, k*zAxis);
          noFill();
          stroke(255); // optional...
          ellipse(pointPaths[i][j].x, pointPaths[i][j].y, dsize, dsize); // try other shapes 

          popMatrix();
          //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
          // [i] refers to which character, [j] refers to which point in that character
        } 

        if (k == 0) {

          for (int j=0; j < pointPaths[i].length; j+=15) { 
            pushMatrix();

            float zAxis = map(easeAudio, 0, maxAudio, -10, 10);
            float dsize = 10;//map(easeAudio, 0, maxAudio, 1, 5);

            rotateX(frameCount*3);
            translate(0, 0, k*zAxis);
            noFill();
            xstroke(0, 0, 150); // optional...
            //xellipse(pointPaths[i][j].x, pointPaths[i][j].y, dsize, dsize); // try other shapes 
            xline(pointPaths[i][j].x, pointPaths[i][j].y, pointPaths[i][j].x+dsize, pointPaths[i][j].y+dsize); // try other shapes 

            popMatrix();
            //vertex(pointPaths[i][j].x, pointPaths[i][j].y); // try other shapes 
            // [i] refers to which character, [j] refers to which point in that character
          }
        }
      }

      popMatrix(); // releases objects from transformations
    }
  } // if pointsPath
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/