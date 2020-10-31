color[] colArray = {
  //color(128, 128, 255), 
  //color(0, 255, 255), 
  //color(248, 64, 248), 
  color(64, 255, 255),
  color(248, 64, 248),
  color(220,40,270)
};

void setup() {
  size(640,480);
  //fullScreen();
  background(0);
  fill(RGB, colArray[int(random(3))],100);
}

void draw() {
  noStroke();
  fill(0, 0, 0, 5);
  rect(0, 0, width, height);
  
  
  if (mousePressed) {
    translate(640, 480);
    float offsetX = mouseX - 640;
    float offsetY = mouseY - 480;
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
