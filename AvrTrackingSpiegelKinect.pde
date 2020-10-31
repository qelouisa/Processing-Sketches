import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float minThresh = 200;
float maxThresh = 600;
PImage img;
color[] colArray = {
  //color(128, 128, 255), 
  //color(0, 255, 255), 
  //color(248, 64, 248), 
  color(64, 255, 255),
  color(248, 64, 248),
  color(220,40,270)
};

void setup() {
  //size(640,480);
  fullScreen();
  background(0);
  fill(RGB, colArray[int(random(3))],100);
  kinect = new Kinect(this);
  kinect.enableMirror(true);
  kinect.initDepth();
  img = createImage(kinect.width, kinect.height, RGB);
  //ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
  noStroke();
  fill(0, 0, 0, 5);
  rect(0, 0, width, height);
  //---
  int[] depth = kinect.getRawDepth();

  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y*kinect.width;
      int d = depth[offset];

      if (d > minThresh && d < maxThresh) {
        img.pixels[offset] = color(255, 200, 100);

        sumX += x;
        sumY += y;
        totalPixels++;
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }
 
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150, 0, 255);
  ellipse(avgX, avgY, 20, 20);
  
  img.updatePixels();
  imageMode (CENTER);
  //image(img, 0, 0);
  
  //if (mousePressed) {
    translate(640, 480);
    float offsetX = avgX - 640;
    float offsetY = avgY - 480;
    stroke(frameCount % 100, 100, 100);
    strokeWeight(20);
    point(offsetX, offsetY);
    point(offsetX, -offsetY);
    point(-offsetX, offsetY);
    point(-offsetX, -offsetY);
    point(offsetY, offsetX);
    point(offsetY, -offsetX);
    point(-offsetY, offsetX);
    point(-offsetY, -offsetX);
    
  }
//}
