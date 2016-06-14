/*
Make a filename with a Date in it. Like this it will be always unique. Even if you restart Processing. 

The java date utils are used. Instead of the build-in year(), month() etc. The reason is that with
DateFormat you can define better which format it needs to be, so that for example the 1st of january 2016
will be formated as: 01-01-2016, instead of 1-1-2016. 

Date and Time patterns:
http://docs.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html

*/

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

Date currentTime; 
DateFormat fileNameFormat; 

String fileName;  
String lastFileName;
String folderName;

int fileNameAddOnNumber = 0;

void setup() {
  
 size(200,100);
 frameRate(10);
 
 fileNameFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
 folderName = "frames";
 
 background(0);
 text("click to save a frame",10,20);
 
}

void draw() {
  
  if (mousePressed == true) {
    
    background(random(40,200),random(40,200),random(40,200));
  
    currentTime = new Date();
    fileName   = fileNameFormat.format(currentTime);
    
    // in case we save multiple files per second we can
    // add milliseconds (S) to the SimpleDateFormat
    // or use the ### symbols in the string (see saveFrame documentation)
    // or in this example just add a counter
    if(fileName.equals(lastFileName)) {
      fileNameAddOnNumber++;
    }
    else {
      // reset the add on number, however we don't add it to the fileName when it's 0.
      fileNameAddOnNumber=0;
      lastFileName = fileName;
    }
    
    fileName   = fileName + "_" +fileNameAddOnNumber; 
    
    text(fileName,10,20);

    saveFrame(sketchPath("")+"/screenshots/"+fileName+".jpg");
  }
  
}