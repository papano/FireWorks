// Yuriy Mavrin https://github.com/papano
// Based on Daniel Shiffman code https://thecodingtrain.com/CodingChallenges/027-fireworks.html 
import peasy.*;
import geomerative.*;

PVector gravity = new PVector(0, 0.2, 0);
ArrayList<ParticleSystem> fireworks;
PeasyCam cam;
float platformWidth;
float platformDepth;
float platformOffset;
RShape grp;
RPoint[] points;
String[] messages;
int messageIndex;
boolean messageInProgress;


void setup() {
  //fullScreen(P3D);
  size(1800, 1800, P3D);
  cam = new PeasyCam(this, 1200);
  fireworks = new ArrayList<ParticleSystem>();
  platformWidth = 1000;
  platformDepth = 600;
  platformOffset = 500;
  RG.init(this);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(20);
  messages = new String[]{"С ДНЁМ", "РОЖДЕНИЯ", "ГАЛЯ"};
  messageIndex = 0;
  messageInProgress = true;
  //background(0);
}

void draw() {
  int i;
  RPoint p;
  ParticleSystem f;

  background(0);
  rotateX(-PI/6);
  drawPlatform();
  //drawAxes(100);

  if (messageInProgress) {
    if (fireworks.isEmpty() && messageIndex < messages.length) {
      grp = RG.getText(messages[messageIndex], "FreeSans.ttf", 220, CENTER);
      ++messageIndex;
      points = grp.getPoints();
      float hue = random(255); 
      for (i = 0; i < points.length; i++) {
        p = points[i];
        f = new ParticleSystem(p.x, platformOffset, p.y, hue);
        f.setChildrenAmount(40);
        fireworks.add(f);
      }
    } else if (fireworks.isEmpty() && messageIndex == messages.length) {
      messageInProgress = false;
      points = null;
    }
    //drawText(points);
  } else if (random(1) < 0.1) {
    f = new ParticleSystem();
    fireworks.add(f);
  }

  for (i = fireworks.size()-1; i >= 0; i--) {
    f = fireworks.get(i);
    f.run();
    if (f.finished()) {
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
  if (points != null) {
    println("text points: " + points.length);
  }
  long totalParticles = 0;
  println("fireworks: " + fireworks.size());
  for (ParticleSystem f : fireworks) {
    totalParticles += f.numOfParticles();
  }
  println("particles: " + totalParticles);
  println("FPS: " + frameRate);
}

void drawText(RPoint[] points) {
  if (points == null) return;
  stroke(80);
  strokeWeight(10);
  for (int i = 0; i < points.length; i++) {
    RPoint p = points[i];
    point(p.x, platformOffset, p.y);
  }
}
