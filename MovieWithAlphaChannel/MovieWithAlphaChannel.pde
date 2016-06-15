/*
Important:
Use the P2D or P3D renderer.
See size-tag.

*/

import processing.video.*;

Movie movie;

void setup() {
  size(640, 480, P2D);

  // Load and play the video in a loop
  movie = new Movie(this, "animationWithAlphaChannel.mov");
  movie.loop();
}

void draw() {
  
  background(frameCount%255);
  
  if (movie.available() == true) {
    movie.read(); 
  }
 
  image(movie, 0, 0); //, 550, 400);
  image(movie, mouseX,mouseY, 220, 200);
  
}

void transparantImage(PImage img, float x, float y) {
  noStroke();
  beginShape();
  
      textureMode(IMAGE);
      texture(img);
    
      vertex(x,             y             , 0,         0         );
      vertex(x + img.width, y             , img.width, 0         );
      vertex(x + img.width, y + img.height, img.width, img.height);
      vertex(x,             y + img.height, 0,         img.height);
      
   endShape();
}

void transparantImage(PImage img, float x, float y, float w, float h) {
  noStroke();
  beginShape();
  
      textureMode(IMAGE);
      texture(img);
    
      vertex(x,     y,     0        , 0         );
      vertex(x + w, y,     img.width, 0         );
      vertex(x + w, y + h, img.width, img.height);
      vertex(x,     y + h, 0        , img.height);
      
   endShape();
}