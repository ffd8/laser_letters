
/*---- YOUR CUSTOM CODE BELOW --------------------------*/



void fSetup() { // custom setup = runs once
}

void fDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "franziska.sarah"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.9; // <- custom size
  myTextLength = 15; // <- custom length for cuts; grösse vom buchstaben
  processType(); // <- function below (comment out if you prefer custom)// kann man deaktivieren
  background(0); // <- up to you if you want a background! kann faded sein
  //backgroundFade(20); // prefer fade?

  pushMatrix(); // only adjusts translate/scale within matrix, am beste nur typo rein

  // rect(50,50,200,200); // vor translate so bleibt es in der ecke 
  translate(width/2, height/2, height/2); // suggestion to draw from center out, ändert 0 Punkt 

  if (pointPaths != null) { // only draw if points ready 
    noFill(); // optional.. 

    for (int i = 0; i < pointPaths.length; i++) { 
      noFill();
      stroke(0, 134, 181); // optional... //blau 

      //fill(255); // optional...
      int maxLoop; // definiert maxLoop, muss unten angegeben werden das maxLoop mit k zu tun hat, k ist eine varaibel für anzahl punkte

      if (avgAudio<maxAudio/3) {//anzahl ändert nach lautstärke
        maxLoop = 1;// anzahl buchstaben hier 1
      } else if (avgAudio<maxAudio/1.5) {
        maxLoop = 2;
      } else {
        maxLoop = 3;
      }

      for (int k=0; k <maxLoop; k++ ) { // ensteht ein loop 
        pushMatrix();



        if (k==0) {// Farbe ändert nach lautstärke
          xstroke(150, 0, 0);//rot
          stroke(255, 0, 0);//rot
          translate(0, 0, -height/1);
        } else if (k==1) {
          stroke(250, 222, 49);//gelb
          translate(0, 0, -height/1);
        } else {
          stroke(255);//blau
          translate(0, 0, -height/1.5);
        }


        if (k==0) {
          xbeginShape(); 
          for (int j=0; j < pointPaths[i].length; j++) { 
            pushMatrix();

            //rotateY(radians(frameCount*.5));


            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
            float audioWave = in.left.get(audioWaveIndex)*ampWave; //linken lautsprecher

            xvertex(pointPaths[i][j].x+audioWave*8, pointPaths[i][j].y+audioWave*8); // reagiert auf Stimme WELLE

            rotateY(radians((j-1)*frameCount*.005));
            line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave*10, audioWave*10, audioWave*10);
            popMatrix();
          } 
          xendShape();
        } else {
          beginShape(); 


          for (int j=0; j < pointPaths[i].length; j++) { 

            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
            float audioWave = in.left.get(audioWaveIndex)*ampWave; //linken lautsprecher


            vertex(pointPaths[i][j].x+audioWave*8, pointPaths[i][j].y+audioWave*8); // reagiert auf Stimme WELLE
          } 
          endShape();


          for (int j=0; j < pointPaths[i].length; j++) { 

            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize())); 
            float audioWave = in.left.get(audioWaveIndex)*ampWave; //linken lautsprecher

            line(pointPaths[i][j].x+audioWave, pointPaths[i][j].y+audioWave*10, audioWave*10, audioWave*10);
          }
        }
        popMatrix();
      }
    }
  }

  popMatrix();
}









/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0; 
// int aSpeed = 0; 


      

    

  


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/