class Particle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean isCore = false;
  float ttl = 0;
  float hue;

  Particle(PVector loc, PVector vel, boolean isCore, float hue) {
    location = loc.copy();
    velocity = vel.copy();
    acceleration = new PVector(0, 0, 0);
    this.isCore = isCore;
    this.hue = hue;
    ttl = 255;
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
    return (isCore && velocity.y >= 0);
  }

  boolean expired() {
    return ttl <= 0;
  }

  void display() {
    colorMode(HSB);
    if (isCore) {
      stroke(hue, 255, 255);
      strokeWeight(6);
    } else {
      stroke(hue, 255, 255, ttl);
      strokeWeight(4);
    }
    point(location.x, location.y, location.z);
  }
}
