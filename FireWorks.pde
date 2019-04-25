// Yuriy Mavrin https://github.com/papano
// Based on Daniel Shiffman code https://thecodingtrain.com/CodingChallenges/027-fireworks.html 
import peasy.*;

PVector gravity = new PVector(0, 0.2, 0);
ArrayList<ParticleSystem> fireworks;
PeasyCam cam;
float platformWidth;
float platformDepth;
float platformOffset;


void setup() {
  fullScreen(P3D);
  //size(1800, 1800, P3D);
  cam = new PeasyCam(this, 1200);
  fireworks = new ArrayList<ParticleSystem>();
  platformWidth = 800;
  platformDepth = 600;
  platformOffset = 500;
  //background(0);
}

void draw() {
  background(0);
  drawPlatform();
  //drawAxes(100);

  if (random(1) < 0.1) {
    ParticleSystem f = new ParticleSystem();
    fireworks.add(f);
  }

  for (int i = fireworks.size()-1; i >= 0; i--) {
    ParticleSystem frwk = fireworks.get(i);
    frwk.run();
    if (frwk.finished()) {
      fireworks.remove(i);
    }
  }
  
  printInfo();
}

void drawPlatform() {
  stroke(255);
  strokeWeight(1);
  fill(20);
  beginShape();
  vertex(-platformWidth/2, platformOffset, -platformDepth/2); 
  vertex(platformWidth/2, platformOffset, -platformDepth/2); 
  vertex(platformWidth/2, platformOffset, platformDepth/2); 
  vertex(-platformWidth/2, platformOffset, platformDepth/2); 
  endShape(CLOSE);
}

void drawAxes(int len) {
  colorMode(RGB);
  stroke(255, 0, 0);
  line(0, 0, 0, len, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, len, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, len);
}

void printInfo() {
  long totalParticles = 0;
  println("fireworks: " + fireworks.size());
  for (ParticleSystem f : fireworks) {
    totalParticles += f.numOfParticles();
  }
  println("particles: " + totalParticles);
  println("FPS: " + frameRate);
}
