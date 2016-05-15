// example on how to use the millis() function to make
// 'loops' with a certain time. 

int currentTime  = 0;
int startedTime  = 0;
int intervalTime = 2000;

color randomColor;

void setup() {
   size(200,200);
   //frameRate(1);
}

void draw() {
  
  background(0);
  
  currentTime = millis();
  
  int timeDifference = currentTime - startedTime;
  
  if(timeDifference > intervalTime) {
    
    // make a random color
    randomColor = color(random(128,256),random(128,256),random(128,256));
    
    // reset the Time
    startedTime = currentTime;
  }
  
  // reset on keyPress
  if(keyPressed) {
     startedTime = millis(); // we could also use currentTime
  }
  
  // display
  fill(randomColor);
  
  text("currentTime | millis(): " + currentTime,   20,20);
  text("startedTime: " + startedTime,    20,40);
  text("timeDifference : " + timeDifference,20,60);
  
  rect(10,90,180,100);
  
}