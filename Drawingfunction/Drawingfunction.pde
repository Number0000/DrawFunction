Particle[] particles = new Particle[1000];
boolean saving = false;

void setup(){
  size(1032,768);
  smooth();
  
  //create particles
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle(new PVector(width/2, height/2));
  }
}

void draw(){
  background(255);
  //draw the particles
  for(int i = 0; i < particles.length; i++){
    particles[i].update();
    particles[i].draw();
  }
}
