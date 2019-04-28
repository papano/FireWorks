class ParticleSystem {
  
  Particle core;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int childrenAmount = 500;

  ParticleSystem() {
    PVector l = new PVector(random(-platformWidth/2, platformWidth/2), 
                            platformOffset, 
                            random(-platformDepth/2, platformDepth/2));
    PVector v = new PVector(0, random(-20, -12), 0);
    core = new Particle(l, v, true, random(255)); 
  }
  
  ParticleSystem(float x, float y, float z, float hue) {
    PVector l = new PVector(x, y, z);
    PVector v = new PVector(0, -15, 0);
    core = new Particle(l, v, true, hue); 
  }

  void update() {
    if (core != null) {
      core.applyForce(gravity);
      core.update();
      if (core.explode()) {
        for (int i = 0; i < childrenAmount; i++) {
          PVector vel = PVector.random3D();
          vel.mult(random(10, 20));
          Particle p = new Particle(core.location, vel, false, core.hue);
          particles.add(p);
        }
        core = null;
      }
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.update();
      if (p.expired()) {
        particles.remove(i);
      }
    }
  }
  
  void display() {
    if (core != null) {
      core.display();
    }
    for (Particle p : particles) {
      p.display();
    }
  }
  
  boolean finished() {
    return (core == null && particles.isEmpty());
  }

  void run() {
    update();
    display();
  }
  
  long numOfParticles() {
    long num = (core != null) ? 1 : 0;
    num += particles.size();
    return num;
  }
  
  void setChildrenAmount(int amount) {
    childrenAmount = amount;
  }
}
