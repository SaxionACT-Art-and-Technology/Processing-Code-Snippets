
// make sure the two arrays have the same length and the name describes the colorHex. 
color [] colorHex    = { #ff0000, #ffff00,  #00ff00, #00ffff, #0000ff, #ff00ff };
String [] colorName  = { "red",   "yellow", "green", "cyan",  "blue", "purple" };

void setup() {
 
  size(600,600);
  ellipseMode(CORNER);
  
  frameRate(1);
  
}

void draw() {
    background(255);
    
    // random color (from synnesketch)
    color randomColor = color(random(255),random(255),random(255));
    
    // show it
    fill(randomColor);
    rect(0,0,200,200);
    
    int closestColorIndex = getClosestColorIndex(randomColor);
    
    // show the basic color
    fill(colorHex[closestColorIndex]);
    rect(200,0,200,200);
    
    // show the color name (actually you put this in chromatik colorName[closestColorIndex])
    fill(0);
    text(colorName[closestColorIndex], 210,20);
}


// return the index number from our two arrays

int getClosestColorIndex(color inputColor) {
    
    int colorArrayIndex = -1; // not existing index 
    
    int closestColorDistance = 195075; // set this to the maximum distance, everything will be lower then
    
    for(int i = 0; i<colorHex.length; i++) {
       
       // check the distance from the input color, with the color from the array
       int thisColorDistance = calculateColorDistance(inputColor, colorHex[i]);
       
       // check if this is the closest if yes store it. 
       // if yes store it. 
       if(thisColorDistance < closestColorDistance) {
          closestColorDistance = thisColorDistance; 
         
          colorArrayIndex = i;
       }
    }
    
    return colorArrayIndex;  
}


int calculateColorDistance( int colour1, int colour2 ) 
{

  int currR = (colour1 >> 16) & 0xFF; 
  int currG = (colour1 >> 8) & 0xFF;
  int currB = colour1 & 0xFF;

  int currR2 = (colour2 >> 16) & 0xFF; 
  int currG2 = (colour2 >> 8) & 0xFF;
  int currB2 = colour2 & 0xFF;

  int distance  = 0;
  distance += Math.pow(currR - currR2, 2);
  distance += Math.pow(currG - currG2, 2);
  distance += Math.pow(currB - currB2, 2);
  return distance ;
} 
