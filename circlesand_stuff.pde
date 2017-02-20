int state;
boolean spectrum;
PVector[] drawArray;
int rgb = (int)random(3);
int off1 = (int) random(255);
int off2 = (int) random(255);

void setup() {
  size(800, 800);
  spectrum = false;
  background(0);
}

void preDraw() {
  state = 0;
  rgb = (int)random(3);
  off1 = (int) random(255);
  off2 = (int) random(255);
}



void drawLines(PVector[] points, boolean spectrum) {
  float offset = 0;
  float specRatio = 255/points.length;
  

    for (int j = 0; j < drawArray.length; j++) {
      if (state != j) {
          if(spectrum){
              spectrum(rgb, offset);
              offset += specRatio;
          }
          else{
              setRandomColor(rgb, off1, off2);
          }
          
          line(points[state].x, points[state].y, points[j].x, points[j].y);
  
      }
    }
  
}

PVector[] drawCube(int size, int radius){
    PVector[] cube = new PVector[4];
    float angle=TWO_PI/(float)size;
    float offsetX = height / 2;
    float offsetY = width / 2;
    for(int i=0;i<4;i++){
        cube[i] = new PVector((radius*sin(angle*i)) + offsetX, radius*cos(angle*i) + offsetY);
    } 
    return cube;
}

PVector[] randomPoints(int size) {
    PVector[] points = new PVector[size];
    
    for (int i = 0; i < size; i++) {
        points[i] = new PVector(random(width), random(height));
    }
    
    return points; 
}


PVector[] circle(int size, float radius){
    PVector[] circle = new PVector[size];
    float angle=TWO_PI/(float)size;
    float offsetX = height / 2;
    float offsetY = width / 2;
    for(int i=0;i<size;i++){
        circle[i] = new PVector((radius*sin(angle*i)) + offsetX, radius*cos(angle*i) + offsetY);
    } 
    return circle;
}

void setRandomColor(int rgb, int off1, int off2){
    float colorRand = random(150) + 50;
    switch (rgb){
        case 0: 
            stroke(off1, off2, colorRand);
            break;
        case 1: 
            stroke(off1, colorRand, off2);
            break;
        case 2:
            stroke(colorRand, off1, off2);
            break;
            
        //todo more colors
    }
}

void spectrum(int rgb, float offset){
    float r = 0;
    float g = 0;
    float b = 0;
    float colorRand = random(150) + 50;
    switch (rgb){
        
        case 0: 
            r = colorRand;
            b = offset;
            break;
        case 1: 
            g = colorRand;
            r = offset;
            break;
        case 2:
            b = colorRand;
            g = offset;
            break;
        case 3: 
            r = colorRand;
            b = colorRand;
            g = offset;
            break;
        case 4: 
            g = colorRand;
            r = colorRand;
            b = offset;
            break;
        case 5:
            b = colorRand;
            g = colorRand;
            r = offset;
            break;
    }
    
    stroke(r, g, b);
    
}

void keyTyped() {
    
    if (key == '1') {
        drawArray = randomPoints((int) random(25) + 5);
        preDraw();
    } else if (key == '2') {
        drawArray = circle((int) random(20) + 10, (int) random(width / 4) + width / 4);
        preDraw();
    } else if (key == '3') {
        drawArray = drawCube(4, (int) random(width / 4) + width / 4);
        preDraw();
    } else if (key == ' ') {
      background(0);
      drawArray = null; 
    }
}

void draw() {
  if (drawArray != null) {
      if (state < drawArray.length - 1) {
        drawLines(drawArray, spectrum);
        state++;
      }
      delay(10);
  }
}