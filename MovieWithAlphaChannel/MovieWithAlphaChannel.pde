/*
  Movies with an alpha channel are only supported in the P2D or P3D renderer. 
  Set that in the size() function.
  
  Animation uses the Quicktime Animation Codec with an alpha channel. 
  (See screenshot of the rendersettings in this folder). 
  
  Included Animation by Kiki van Marrewijk.
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