class Particle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean isCore = false;
  float ttl = 0;
  float hue;

  Particle(float x, float y, float z, float hue) {
    location = new PVector(x, y, z);
    velocity = new PVector(0, random(-20, -12), 0);
    acceleration = new PVector(0, 0, 0);
    isCore = true;
    this.hue = hue;
  }

  Particle(PVector loc, float hue) {
    location = loc.copy();
    velocity = PVector.random3D();
    velocity.mult(random(10, 20));
    acceleration = new PVector(0, 0, 0);
    isCore = false;
    ttl = 255;
    this.hue = hue;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    if (!isCore) {
      velocity.mult(0.9);
    }
    acceleration.mult(0);
    ttl -= 255/90;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  boolean explode() {
    return velocity.y >= 0;
  }

  boolean expired() {
    return ttl <= 0;
  }

  void display() {
    colorMode(HSB);
    if (isCore) {
      stroke(hue, 0, 255);
      strokeWeight(8);
    } else {
      stroke(hue, 255, 255, ttl);
      strokeWeight(4);
    }
    point(location.x, location.y, location.z);
  }
}
