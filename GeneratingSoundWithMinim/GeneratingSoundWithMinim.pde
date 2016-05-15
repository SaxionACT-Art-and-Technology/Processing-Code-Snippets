// example with the Minim libary.
// we turn on of the sound by changing the amplitude from 1.0 to 0.0
// the stop() function seems to have a bug.

// press 1,2,3,4,5 to hear the sounds. 

// if you have problems you could also use Minim
// http://code.compartmental.net/minim/oscil_class_oscil.html

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       wave;

// array with note frequencies of G3, C4, E4, and G4
float [] simonTones = { 195.998, 261.626, 329.628, 391.995, 49 };

void setup() {
    size(640,360);
    background(255);
    
    // Create and start the square oscillator.
    minim = new Minim(this);
    // use the getLineOut method of the Minim object to get an AudioOutput object
    out = minim.getLineOut();
  
    // create a square wave Oscil, set to 0 Hz, at 0.0 amplitude
    wave = new Oscil(simonTones[0], 0.0, Waves.SQUARE );
    // patch the Oscil to the output
    wave.patch( out );
}

void draw() {
  
}

void keyPressed() {
   
  // convert keys 1,2,3,4,5 to an index of 0,1,2,3,4
  int keyInt = (int) key - 48 - 1;
  
  if(keyInt >=0 && keyInt < 5) {
    wave.setFrequency(simonTones[keyInt]);
    // 0.7 is loud enough... don't crank it up till 1.0
    wave.setAmplitude(0.7); 
  }
  
}

void keyReleased() {
  
   wave.setAmplitude(0.0);
   
}