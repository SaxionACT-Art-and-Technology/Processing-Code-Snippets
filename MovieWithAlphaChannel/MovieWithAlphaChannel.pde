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