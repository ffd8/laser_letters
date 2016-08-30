
float cop;
int j=0;
int audioWaveIndex ;  

int v;
float a ;


void aSetup() { // custom setup = runs once
}

void aDraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  credits = "nils.dobberstein"; // put your name[s] here!
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.8; // *NEW* set text size (0 - height)
  useLowerCase = false; // *NEW* optionally set true for lowercase
  myTextLength = 15; // custom cut length
  processType(); // takes care of type for you, turn off if using custom
  background(0); // default background
  //backgroundFade(30); // very experimental.. sorta fails in 3D


 a = a +.02;
  cop=sin(frameCount *.009);
  cop =cop+0.2;
  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2, -height/2); // suggestion to draw from center out 
float superTurn = (maxAudio);
  rotateY(cop+superTurn);
  translate(0,0,superTurn);

  if (pointPaths != null) { // only draw if points ready 
    //noFill(); // optional.. 
    stroke(255);
            rotateY(cop);
                  if (maxAudio<0.1) {
        rotateY(superTurn);
      } 
    pushMatrix();

    for (int k =0; k<map(avgAudio, 0, maxAudio, 0, 10); k++) {  //anzahl loop rechtecke
  

        int i = 0;
       // int transform = (floor(map(avgAudio, 0, maxAudio, 0, height/20)));
       // translate(0, 0, (map(avgAudio, 0, maxAudio, 0, height/10)));
       translate(0,0,maxAudio);
          beginShape(); 
          for (int j=0; j < pointPaths[i].length; j++) { 
                int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  //new
          float audioWave = in.left.get(audioWaveIndex)*ampWave; //new
            stroke(255);
            rect(pointPaths[i][j].x+(map(avgAudio, 0, maxAudio, 0, height/10)+audioWave), pointPaths[i][j].y+(map(avgAudio, 0, maxAudio, 0, height/20)+audioWave), 3+audioWave*2, 3+audioWave*2);

           
          
            noFill();
          }
          endShape();
      }
    popMatrix();
    for (int k =0; k<map(avgAudio, 0, maxAudio, 0, 3); k++) {
      for (int i = 1; i < pointPaths.length; i++) {
       
        int transform = (floor(map(avgAudio, 0, maxAudio, 0, height/10)));
        translate(0, 0, transform);
       
           //xstroke(map(avgAudio, 0, maxAudio, 20, 255)+audioWave,audioWave,map(avgAudio, 4, maxAudio, 255, 0)+avgAudio);
          xstroke(map(avgAudio, 0, maxAudio, 20, 255),0,map(avgAudio, 4, maxAudio, 255, 0));
          xbeginShape(); 
          for (int j=0; j < pointPaths[i].length; j++) { 

          //  stroke(255,0,255);
            if(map(easeAudio, 0, maxAudio, 0, 5)>= .1){
            int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, in.bufferSize()));  
            float audioWave = in.left.get(audioWaveIndex)*ampWave; 
            
            xvertex(pointPaths[i][j].x+(map(avgAudio, 0, maxAudio, 0, height/20)), pointPaths[i][j].y);
            xvertex(pointPaths[i][(j+1)%pointPaths[i].length].x,pointPaths[i][(j+1)%pointPaths[i].length].y);
            //xline(pointPaths[i][j].x+(map(avgAudio, 0, maxAudio, 0, height/20)), pointPaths[i][j].y,pointPaths[i][(j+1)%pointPaths[i].length].x, pointPaths[i][(j+1)%pointPaths[i].length].y);
            noFill();
            
            }
         
          xendShape();
      }
    }
  }
   }

    popMatrix();
  }

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/