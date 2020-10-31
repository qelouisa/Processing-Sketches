import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float minThresh = 200;
float maxThresh = 600;
PImage img;

float sw, alpha;
float yStep = 10;
float arcSize = 200;

void setup() {
  size(640, 480);
  kinect = new Kinect(this);
  kinect.enableMirror(true);
  kinect.initDepth();
  img = createImage(kinect.width, kinect.height, RGB);
}

void draw() {
  background(#eeeeee);
  
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
  //image(img, 0, 0);

  //mouseX = constrain(mouseX, 10, width);
  //mouseY = constrain(mouseY, 10, width);
  
  avgX = constrain(avgX, 5, width);
  avgY = constrain(avgY, 5, width);

  yStep = avgY;
  arcSize = avgX;
  
  noFill();
  stroke(20);

  for (float y=+arcSize/2; y<height-arcSize/2; y+=yStep) {
    sw = map(sin(radians(y+alpha)), -1, 1, 2, yStep);
    strokeWeight(sw);
    for (float x1=arcSize/2; x1<width+arcSize; x1+=arcSize) {
      arc(x1, y, arcSize/2, arcSize/2, 0, PI);
    }
    sw = map(sin(radians(y-alpha)), -1, 1, 2, yStep);
    strokeWeight(sw);
    for (float x2=0; x2<width+arcSize; x2+=arcSize) {
      arc(x2, y, arcSize/2, arcSize/2, PI, TWO_PI);
    }
  }
  alpha++;
}
