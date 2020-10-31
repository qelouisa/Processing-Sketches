float angle;
color[] colArray = {
  color(128, 128, 255), 
  color(0, 255, 255), 
  color(248, 64, 248), 
  color(64, 255, 255)
};

void setup() {
  size(640, 480);
  //surface.setLocation(957, 0);
  noStroke();
  fill(0, 15, 30);
}

void draw() {
  background(20);

  mouseX = constrain(mouseX, 10, width);
  mouseY = constrain(mouseY, 10, width);

  //float angle;
  float x = width;
  float dia = 200;
  //int num = 100;
  int num = mouseX;
  int mun = mouseY;
  
  surface.setLocation(957, 0);

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
