// In this example you need crack the code in the array. 
// With a click of the mouse your render a new code.
// In the console you can peek what it is :)

int [] codeArray = { 1, 2, 3, 4 };
int codePosition = 0;

int keyValue;

boolean checkInput = false;

void setup() {
  size(200,200);
  textSize(20); 
}

void draw() {
    background(0);
    
    // only do this when a key is pressed
    // when a key is pressed this checkInput will be true
    if(checkInput) {
      
      // set it to false, so we don't end up here again (without pressing a key)
      // try to remove this line to see what happens.
      checkInput = false;
      
      // check if the codePosition isn't higher then four
      // if that is the case we first have to reset
      if(codePosition<4) {
        if(keyValue == codeArray[codePosition]) {
          
          // the same, color green
          fill(0,255,0);
          
          // next position        
          codePosition++; // codePosition = codePostion + 1; 
        }
        else {
          // different color red
          fill(255,0,0);
        }
      }
                
  }
     
  text("position: " + codePosition,10,20);  
  
  // reveal the code on the screen
  text("code: ",10,60);
  if(codePosition>0) text(codeArray[0],10,100);
  if(codePosition>1) text(codeArray[1],30,100);
  if(codePosition>2) text(codeArray[2],50,100);
  if(codePosition>3) text(codeArray[3],70,100);
    
}

void mouseClicked() {
   
  // render new code
  for(int i = 0; i<4; i++) {
     codeArray[i] = int(random(1,4)); 
   
  }
  // reset code position
  codePosition = 0;

  // show it in the console
  //printArray(codeArray);
  println(join(nfs(codeArray,1), ","));
  
}

void keyPressed() {
  
  //println("pressed: "+key);
  
  // convert key to integer
  // we do this for comparision with the integers of the code array. 
  // substraction with 50 because we have the ascii table value
  keyValue = (int)key - 48; 
 
  checkInput = true;
}