/*
    Sync movies in Processing. 
    Best result is with Quicktime Animation. H264 stutters (at least on Mac) with
    decompression. Counter side is that Quicktime Animation files are really big. 
    About 5Mb per second. 

    Also make sure you always display the synced movie. If you take it on/off screen.
    with image, it won't be in sync. 
*/

import processing.video.*;

Movie movieRed;
Movie movieBlue;

void setup() {

  size( 1280, 360, P2D );
  frameRate(25);

  //println(movieRed.duration());
  //println(movieBlue.duration());

  movieRed = new Movie(this, "syncMovieRed.mov");
  movieBlue = new Movie(this, "syncMovieBlue.mov");
}

void draw() {

  movieRed.loop();
  
  movieBlue.loop();
  movieBlue.volume(0);
  movieBlue.jump(movieRed.time());
  
  movieRed.read();
  movieBlue.read();

  if (mousePressed) {
    image(movieBlue, 0, 0, 640, 360);   // movieBlue left
    image(movieBlue, 640, 0, 640, 360); // movieBlue right
    
    // display red with a width/height of 0
    // in this case it will be good in sync when we release the mouse again
    image(movieRed, 640, 0, 0, 0);
    
    
  } else {
    image(movieRed, 0, 0, 640, 360);    // movieRed left
    image(movieBlue, 640, 0, 640, 360); // movieBlue right
  }
}