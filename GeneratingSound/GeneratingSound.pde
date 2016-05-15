// example with the Processing Sound libary.
// check if you have version 1.3 (import library > add library...)
// it doesn't work in the 32bit Windows version of Processing and with Processing versions lower then 3.0

// we turn on of the sound by changing the amplitude from 1.0 to 0.0
// the stop() function seems to have a bug.

// press 1,2,3,4,5 to hear the sounds. 

// if you have problems you could also use Minim
// http://code.compartmental.net/minim/oscil_class_oscil.html

import processing.sound.*;

// array with note frequencies of G3, C4, E4, and G4
float [] simonTones = { 195.998, 261.626, 329.628, 391.995, 49 };

SqrOsc sqr;

void setup() {
    size(640,360);
    background(255);
    
    // Create and start the square oscillator.
    sqr = new SqrOsc(this);
    sqr.play();
    // Turn volume down, we turn it up to play a sound
    sqr.amp(0.0);
}

void draw() {
  
}

void keyPressed() {
   
  // convert keys 1,2,3,4,5 to an index of 0,1,2,3,4
  int keyInt = (int) key - 48 - 1;
  
  if(keyInt >=0 && keyInt < 5) {
    sqr.freq(simonTones[keyInt]);
    // 0.7 is loud enough... don't crank it up till 1.0
    sqr.amp(0.7); 
  }
  
}

void keyReleased() {
  
   sqr.amp(0.0);
   
}