import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float minThresh = 200;
float maxThresh = 600;
PImage img;

float angle;
color[] colArray = {
  color(128, 128, 255), 
  color(0, 255, 255), 
  color(248, 64, 248), 
  color(64, 255, 255)
};

void setup() {
  size(800, 800);
  surface.setLocation(957, 0);
  noStroke();
  fill(0, 15, 30);
  kinect = new Kinect(this);
  kinect.enableMirror(true);
  kinect.initDepth();
  img = createImage(kinect.width, kinect.height, RGB);
}



void draw() {
  background(20);

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
  ellipse(avgX, avgY, 5, 5);

  img.updatePixels();
  imageMode (CENTER);

  //mouseX = constrain(mouseX, 10, width);
  //mouseY = constrain(mouseY, 10, width);

avgX = constrain(avgX, 5, width);
  avgY = constrain(avgY, 5, width);

  float x = width;
  float dia = 300;
  //int num = 100;
  float num = avgX;
  float mun = avgY;

  translate(width/2, height/2);  
  for (float a=0; a<360; a+=90) {
    //fill(248, 64, 248);
    fill(64, 255, 255);
    //stroke(20);
    //strokeWeight(20);
    //fill(colArray[int(random(5))]);
    rotate(radians(a));
    pushMatrix();
    for (int i=0; i<num; i++) {
      scale(0.95);
      rotate(radians(angle));
      ellipse(x, 0, dia, dia);
    }
    popMatrix();

    pushMatrix();
    for (int i=0; i<mun; i++) {
      fill(64, 255, 255);
      //stroke(20);
      //strokeWeight(20);
      scale(0.95);
      rotate(-radians(angle));
      ellipse(x, 0, dia, dia);
    }
    popMatrix();
  }
  angle+=0.01;
}
