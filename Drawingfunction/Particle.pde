class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  
  PVector[] hist;
  int counter = 0;
  
  Particle(PVector l){
    float randmin = -HALF_PI;
    float randmax = 0;
    
    float r = random(0, TWO_PI);
    float x = cos(r) * r;
    float y = sin(r) * r;
    acc = new PVector(x / 250, y / 250);
    
    float q = random(-1, 1);
    r = random(randmin, randmax);
    x = cos(r) * q * q * q;
    y = sin(r) * q * q * q;
    vel = new PVector(2*x, 2*y);
    loc = l.get();
    hist = new PVector[1000];
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    
    //save location every 10 frames
    if(frameCount % 10 == 0 && counter < hist.length){
      hist[counter] = loc.get();
      counter++;
    }
  }
  
  void draw(){
    fill(100, 50);
    drawArrowHead(vel, loc, 10);
    noFill();
    //draw history path
    stroke(0, 100);
    beginShape();
    for(int i = 0; i < counter; i++){
      vertex(hist[i].x, hist[i].y);
    }
    if(counter > 0) vertex(loc.x, loc.y);
    endShape();
  }
  
  void drawArrowHead(PVector v, PVector loc, float scale){
    pushMatrix();
    float arrowsize = 4;
    // translate to location to render vector
    translate(loc.x, loc.y);
    
    // rotate to heading
    rotate(v.heading2D());
    
    // calculate length of vector & scale it to bigger or smaller if necessary
    float len = v.mag() * scale;
    arrowsize = map(len, 0, 10, 0, 1) * arrowsize;
    
    //Draw point
    stroke(0, 100);
    fill(0, 100);
    line(0, 0, len-arrowsize, 0);
    noStroke();
    beginShape();
    vertex(len, 0);
    vertex(len-arrowsize, +arrowsize/2);
    vertex(len-arrowsize, -arrowsize/2);
    endShape(CLOSE);
    popMatrix();
  }
}
