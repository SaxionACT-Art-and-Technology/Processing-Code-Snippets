/*  Processing doesn't support video with an alpha channel. 
    
    A solution is to render a video with a solid color (like a greenscreen) and filter that. 
    This sketch uses a Shader to remove a certain color. 
    You also can do it with a "pixel loop" like explained over here: https://processing.org/tutorials/pixels/
    However shaders a generally faster, because they are processed with the GPU instead of the CPU.

    See the chromashader.glsl file for more details about the chromashader.
    
    copyleft: kasperkamperman.com - 09 - 06 - 2015
*/

import processing.video.*;

Movie movie;

PImage bg;

PShader chromakey; 

void setup() {

  // make the mode P2D, shaders are not support in the standard mode
  size(640, 360, P2D);
  
  // import the shader (stored in the data folder)
  chromakey = loadShader( "chromashader.glsl" );
  
  chromakey.set("resolution", float(width), float(height));
  //uniform vec2 resolution;
  //use resolution.xy
  
  // pass the parameters to the shader
  // to get the right numbers press the mouse to get the color that you'd like to use for your key
  chromakey.set( "keyColor", 0.0, 0.0, 0.0);
  
  // despill gives blocky results on some compressed footage
  chromakey.set( "despill", false );
  
  bg = loadImage("moonwalk.jpg");
  
  movie = new Movie(this, "greenloop.mp4");
  movie.loop();
}

void draw() {
  background(0);
  image(bg,0,0);

  shader(chromakey);
  image( movie, 0, 0 , width, height);
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed() {
   
  // just a way to get the right color of chromakeying
  color c = movie.get(mouseX, mouseY);
  
  println("pixel color (0-255): "+ red(c) + ", " + green(c) + ", " +  blue(c));
  
  // convert to floats with range 0.0 - 1.0 for the shader
  float r = red(c)/255.0;
  float g = green(c)/255.0;
  float b = blue(c)/255.0;
  
  println("pixel color (0.0-1.0): " + nf(r,0,3) + ", " + nf(g,0,3) + ", " +  nf(b,0,3));
  
  chromakey.set( "keyColor", r, g, b);
}