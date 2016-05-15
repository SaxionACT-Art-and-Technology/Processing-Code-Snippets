// In this example we use a character array to store
// a pressed key. 
// We move to 0 when we reach the end of the array

char [] storeArray = new char[6];
int arrayPosition = 0;

void setup() {
  size(200,100);
  
  fill(255);
  textSize(20);
}

void draw() {
  background(0);
  
  String arrayContents = new String(storeArray);
  
  text("position: " + arrayPosition,10,30);
  text("array: " + arrayContents,10,60);  
}

void keyPressed() {
  
  storeArray[arrayPosition] = key;
  arrayPosition++;
  if(arrayPosition > storeArray.length-1) arrayPosition = 0;

}